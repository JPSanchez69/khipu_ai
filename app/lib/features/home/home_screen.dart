import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../core/theme/khipu_theme.dart';
import '../../infrastructure/ai/gemma_teacher_ai.dart';
import '../lesson/whiteboard/whiteboard_canvas.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    final bytes =
        camera ? await picker.pickFromCamera() : await picker.pickFromGallery();
    if (bytes != null) {
      ref.read(attachedImageProvider.notifier).set(bytes);
    }
  }

  Future<void> _installModelFromDownloads() async {
    final progress = ref.read(modelInstallProgressProvider.notifier);
    progress.set(0);
    try {
      await ref.read(gemmaInstallerProvider).installFromDownloads(
            onProgress: progress.set,
          );
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
      await ref.read(gemmaInstallerProvider).installFromNetwork(
            onProgress: progress.set,
          );
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
            'Descarga falló. Usa Descargas o revisa el token HF.',
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
                title: const Text('Descargar una vez (Wi‑Fi)'),
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
    final attached = ref.watch(attachedImageProvider);
    final installProgress = ref.watch(modelInstallProgressProvider);
    final busy = ui.phase == LessonPhase.thinking ||
        ui.phase == LessonPhase.playing ||
        installProgress != null;

    final installer = ref.watch(gemmaInstallerProvider);
    final gemmaReady = useGemma && installer.hasActiveModel;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Khipu',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Instalar modelo Gemma',
                    onPressed: busy ? null : _showModelMenu,
                    icon: const Icon(Icons.model_training_outlined),
                  ),
                  FilterChip(
                    label: Text(
                      useGemma
                          ? (gemmaReady ? 'Gemma' : 'Gemma…')
                          : 'Stub',
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
              const SizedBox(height: 4),
              Text(
                useGemma && !gemmaReady
                    ? 'Gemma no listo — instala el .litertlm desde Descargas'
                    : 'Tu profesor en el bolsillo — sin internet',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: KhipuTheme.leaf,
                    ),
              ),
              if (installProgress != null) ...[
                const SizedBox(height: 8),
                LinearProgressIndicator(value: installProgress / 100),
                Text('Instalando modelo… $installProgress%'),
              ],
              if (ui.engineHint != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Motor: ${ui.engineHint}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
              const SizedBox(height: 16),
              Expanded(
                flex: 5,
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
                  color: Colors.white.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (board.socraticPrompt != null) ...[
                      Text(
                        'Pregunta',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: KhipuTheme.clay,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        board.socraticPrompt!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                    ],
                    Text(
                      ui.statusMessage,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (ui.errorMessage != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        ui.errorMessage!,
                        style: const TextStyle(color: KhipuTheme.clay),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _chips.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    return ActionChip(
                      label: Text(_chips[i], overflow: TextOverflow.ellipsis),
                      onPressed: busy ? null : () => _submit(_chips[i]),
                    );
                  },
                ),
              ),
              if (attached != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        attached,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: Text('Foto lista (comprimida)')),
                    IconButton(
                      onPressed: busy
                          ? null
                          : () =>
                              ref.read(attachedImageProvider.notifier).clear(),
                      icon: const Icon(Icons.close),
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
                  const SizedBox(width: 4),
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
                      onPressed: () =>
                          ref.read(lessonUiProvider.notifier).stop(),
                      icon: const Icon(Icons.stop),
                    )
                  else if (!busy)
                    IconButton.filled(
                      onPressed: () => _submit(),
                      icon: const Icon(Icons.send_rounded),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
