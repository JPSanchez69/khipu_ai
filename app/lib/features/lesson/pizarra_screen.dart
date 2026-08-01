import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/navigation_providers.dart';
import '../../core/di/providers.dart';
import '../../core/theme/khipu_colors.dart';
import '../../core/theme/khipu_text_styles.dart';
import '../../core/theme/khipu_theme.dart';
import '../../infrastructure/ai/gemma_teacher_ai.dart';
import 'whiteboard/whiteboard_canvas.dart';

/// Tab "Pizarra IA": el tutor. Input de texto + micrófono, la IA piensa
/// y dibuja pasos en la pizarra. Ver spec de frontend seccion 4.4.
class PizarraScreen extends ConsumerStatefulWidget {
  const PizarraScreen({super.key});

  @override
  ConsumerState<PizarraScreen> createState() => _PizarraScreenState();
}

class _PizarraScreenState extends ConsumerState<PizarraScreen> {
  final _controller = TextEditingController();
  var _listening = false;

  static const _chips = [
    '¿Cómo resuelvo 2x + 3 = 11?',
    'Ana tiene 5 manzanas y compra 3 más',
    '¿Por qué se extinguieron los dinosaurios?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit([String? text]) async {
    final q = (text ?? _controller.text).trim();
    final hasImage = ref.read(attachedImageProvider) != null;
    if (q.isEmpty && !hasImage) return;
    if (q.isNotEmpty) _controller.text = q;
    await ref.read(lessonUiProvider.notifier).ask(q);
  }

  Future<void> _listen() async {
    final stt = ref.read(sttProvider);
    setState(() => _listening = true);
    try {
      final heard = await stt.listenOnce();
      if (heard != null && heard.isNotEmpty) {
        _controller.text = heard;
        await _submit(heard);
      }
    } finally {
      if (mounted) setState(() => _listening = false);
    }
  }

  Future<void> _pickPhoto(bool camera) async {
    final picker = ref.read(photoPickerProvider);
    final bytes = camera
        ? await picker.pickFromCamera()
        : await picker.pickFromGallery();
    if (bytes != null) {
      ref.read(attachedImageProvider.notifier).set(bytes);
    }
  }

  Future<void> _installModelFromDownloads() async {
    final progress = ref.read(modelInstallProgressProvider.notifier);
    progress.set(0);
    try {
      await ref
          .read(gemmaInstallerProvider)
          .installFromDownloads(onProgress: progress.set);
      ref.invalidate(teacherAiProvider);
      ref.read(useGemmaProvider.notifier).set(true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Modelo Gemma E2B instalado')),
      );
    } catch (e) {
      debugPrint('Khipu: install from Downloads failed: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No hay .litertlm en Descargas. Copia el modelo y reintenta.',
          ),
        ),
      );
    } finally {
      progress.set(null);
    }
  }

  Future<void> _installModelFromNetwork() async {
    final progress = ref.read(modelInstallProgressProvider.notifier);
    progress.set(0);
    try {
      await ref
          .read(gemmaInstallerProvider)
          .installFromNetwork(onProgress: progress.set);
      ref.invalidate(teacherAiProvider);
      ref.read(useGemmaProvider.notifier).set(true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Modelo descargado e instalado')),
      );
    } catch (e) {
      debugPrint('Khipu: install from network failed: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Descarga falló. Usa archivo local o revisa el token HF.',
          ),
        ),
      );
    } finally {
      progress.set(null);
    }
  }

  void _showModelMenu() {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.download_done_outlined),
                title: const Text('Instalar desde Descargas'),
                subtitle: const Text('gemma-3n-E2B-it-int4.litertlm'),
                onTap: () {
                  Navigator.pop(ctx);
                  _installModelFromDownloads();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cloud_download_outlined),
                title: const Text('Descargar una vez (Wi-Fi)'),
                subtitle: const Text('Requiere acceso HF + token opcional'),
                onTap: () {
                  Navigator.pop(ctx);
                  _installModelFromNetwork();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ui = ref.watch(lessonUiProvider);
    final board = ref.watch(boardStateProvider);
    final useGemma = ref.watch(useGemmaProvider);
    final cursoContexto = ref.watch(pizarraContextProvider);
    final attached = ref.watch(attachedImageProvider);
    final installProgress = ref.watch(modelInstallProgressProvider);
    final installer = ref.watch(gemmaInstallerProvider);
    final gemmaReady = useGemma && installer.hasActiveModel;
    final busy =
        ui.phase == LessonPhase.thinking ||
        ui.phase == LessonPhase.playing ||
        installProgress != null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final sidePanel = _SidePanel(
          busy: busy,
          chips: _chips,
          onExample: _submit,
        );

        final boardColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: WhiteboardCanvas(
                  key: ValueKey(board.actionIndex),
                  state: board,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: KhipuColors.surfaceMuted,
                borderRadius: BorderRadius.circular(KhipuRadius.card),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (board.socraticPrompt != null) ...[
                    Text(
                      'Pregunta',
                      style: KhipuTextStyles.body.copyWith(
                        color: KhipuColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      board.socraticPrompt!,
                      style: KhipuTextStyles.body.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(ui.statusMessage, style: KhipuTextStyles.body),
                  if (ui.errorMessage != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      ui.errorMessage!,
                      style: const TextStyle(color: KhipuColors.danger),
                    ),
                  ],
                  if (installProgress != null) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: installProgress / 100,
                        minHeight: 6,
                        backgroundColor: KhipuColors.surface,
                        valueColor: const AlwaysStoppedAnimation(
                          KhipuColors.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Instalando modelo… $installProgress%',
                      style: KhipuTextStyles.body.copyWith(fontSize: 12.5),
                    ),
                  ],
                  if (ui.engineHint != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Motor: ${ui.engineHint}',
                      style: KhipuTextStyles.body.copyWith(
                        fontSize: 12,
                        color: KhipuColors.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (attached != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(KhipuRadius.sm),
                    child: Image.memory(
                      attached,
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Foto lista (comprimida)',
                      style: KhipuTextStyles.body.copyWith(fontSize: 13),
                    ),
                  ),
                  IconButton(
                    onPressed: busy
                        ? null
                        : () => ref.read(attachedImageProvider.notifier).clear(),
                    icon: const Icon(Icons.close, size: 18),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !busy,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(
                      hintText: 'Escribe tu pregunta…',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  onPressed: busy ? null : () => _pickPhoto(false),
                  icon: const Icon(Icons.photo_library_outlined),
                  tooltip: 'Galería',
                ),
                IconButton.filledTonal(
                  onPressed: busy ? null : () => _pickPhoto(true),
                  icon: const Icon(Icons.photo_camera_outlined),
                  tooltip: 'Cámara',
                ),
                IconButton.filledTonal(
                  onPressed: busy || _listening ? null : _listen,
                  icon: Icon(_listening ? Icons.hearing : Icons.mic),
                  tooltip: 'Hablar',
                ),
                const SizedBox(width: 4),
                if (busy && installProgress == null)
                  IconButton.filled(
                    onPressed: () => ref.read(lessonUiProvider.notifier).stop(),
                    icon: const Icon(Icons.stop),
                  )
                else if (installProgress == null)
                  IconButton.filled(
                    onPressed: () => _submit(),
                    icon: const Icon(Icons.send_rounded),
                  ),
              ],
            ),
          ],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cursoContexto == null
                            ? 'Pizarra IA'
                            : 'Pizarra IA — $cursoContexto',
                        style: KhipuTextStyles.heading.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pregúntale a tu tutor por voz o texto. Te explica '
                        'hablando y dibujando.',
                        style: KhipuTextStyles.body.copyWith(
                          fontSize: 13.5,
                          color: KhipuColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: busy ? null : _showModelMenu,
                  icon: const Icon(Icons.model_training_outlined),
                  tooltip: 'Instalar modelo Gemma',
                  color: KhipuColors.textSecondary,
                ),
                FilterChip(
                  label: Text(
                    useGemma ? (gemmaReady ? 'Gemma' : 'Gemma…') : 'Stub',
                  ),
                  selected: useGemma,
                  onSelected: busy
                      ? null
                      : (v) {
                          ref.read(useGemmaProvider.notifier).set(v);
                          final t = ref.read(teacherAiProvider);
                          if (t is GemmaTeacherAi) t.invalidate();
                        },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 5, child: boardColumn),
                        const SizedBox(width: 22),
                        SizedBox(width: 300, child: sidePanel),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 460, child: boardColumn),
                          const SizedBox(height: 18),
                          sidePanel,
                        ],
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _SidePanel extends ConsumerWidget {
  const _SidePanel({
    required this.busy,
    required this.chips,
    required this.onExample,
  });

  final bool busy;
  final List<String> chips;
  final Future<void> Function(String) onExample;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useGemma = ref.watch(useGemmaProvider);
    final installer = ref.watch(gemmaInstallerProvider);
    final gemmaReady = useGemma && installer.hasActiveModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _PanelCard(
          title: 'Preguntas de ejemplo',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final c in chips) ...[
                OutlinedButton(
                  onPressed: busy ? null : () => onExample(c),
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    foregroundColor: KhipuColors.textPrimary,
                    side: const BorderSide(color: KhipuColors.border),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                  ),
                  child: Text(
                    c,
                    style: KhipuTextStyles.body.copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        _PanelCard(
          title: 'Tu racha',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '4',
                style: KhipuTextStyles.heading.copyWith(
                  fontSize: 32,
                  color: KhipuColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'días seguidos\npracticando',
                  style: KhipuTextStyles.body.copyWith(
                    fontSize: 13,
                    color: KhipuColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _PanelCard(
          title: 'Estado del modelo',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ModelStatusLine('📦 Gemma-3n E2B-it · int4 (.litertlm)'),
              const _ModelStatusLine('⚡ Motor LiteRT-LM (flutter_gemma)'),
              const _ModelStatusLine('📴 Sin conexión requerida'),
              _ModelStatusLine(
                useGemma
                    ? (gemmaReady ? '✅ Modelo activo' : '⬇️ Falta instalar')
                    : '🧪 Usando respuestas de ejemplo (Stub)',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ModelStatusLine extends StatelessWidget {
  const _ModelStatusLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: KhipuTextStyles.body.copyWith(
          fontSize: 13,
          color: KhipuColors.textSecondary,
        ),
      ),
    );
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: KhipuColors.surface,
        borderRadius: BorderRadius.circular(KhipuRadius.card),
        border: Border.all(color: KhipuColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: KhipuTextStyles.body.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: KhipuColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
