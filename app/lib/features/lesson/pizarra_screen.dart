import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/navigation_providers.dart';
import '../../core/di/providers.dart';
import '../../core/theme/khipu_colors.dart';
import '../../core/theme/khipu_text_styles.dart';
import '../../core/theme/khipu_theme.dart';
import '../../infrastructure/ai/gemma_teacher_ai.dart';
import '../../domain/ports/teacher_ai_port.dart';
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

  Future<void> _installModelLocalWeb() async {
    final progress = ref.read(modelInstallProgressProvider.notifier);
    progress.set(0);
    try {
      await ref
          .read(gemmaInstallerProvider)
          .installLocalWeb(onProgress: progress.set);
      ref.invalidate(teacherAiProvider);
      ref.read(useGemmaProvider.notifier).set(true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gemma local instalado en Chrome')),
      );
    } catch (e) {
      debugPrint('Khipu: instalación web local falló: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se pudo leer el modelo local. Ejecuta ..\\run_web.cmd y revisa la carpeta models.',
          ),
        ),
      );
    } finally {
      progress.set(null);
    }
  }

  Future<void> _showProfileDialog() async {
    final database = ref.read(databaseProvider);
    final profile = await database.getProfile();
    if (!mounted) return;
    final age = TextEditingController(text: profile.age.toString());
    final grade = TextEditingController(text: profile.grade);
    var level = profile.detectedLevel;
    var locale = profile.locale;
    var preference = profile.learningPreference;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Perfil del estudiante'),
          content: SizedBox(
            width: 430,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Edad'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: grade,
                    decoration: const InputDecoration(labelText: 'Grado'),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: level,
                    decoration: const InputDecoration(
                      labelText: 'Nivel detectado',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'basic', child: Text('Básico')),
                      DropdownMenuItem(
                        value: 'intermediate',
                        child: Text('Intermedio'),
                      ),
                      DropdownMenuItem(
                        value: 'advanced',
                        child: Text('Avanzado'),
                      ),
                    ],
                    onChanged: (value) =>
                        setDialogState(() => level = value ?? level),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: locale,
                    decoration: const InputDecoration(labelText: 'Idioma'),
                    items: const [
                      DropdownMenuItem(
                        value: 'es-PE',
                        child: Text('Español peruano'),
                      ),
                      DropdownMenuItem(
                        value: 'es-MX',
                        child: Text('Español mexicano'),
                      ),
                      DropdownMenuItem(
                        value: 'es-ES',
                        child: Text('Español de España'),
                      ),
                    ],
                    onChanged: (value) =>
                        setDialogState(() => locale = value ?? locale),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: preference,
                    decoration: const InputDecoration(labelText: 'Preferencia'),
                    items: const [
                      DropdownMenuItem(
                        value: 'visual',
                        child: Text('Explicación visual'),
                      ),
                      DropdownMenuItem(
                        value: 'examples',
                        child: Text('Ejemplos prácticos'),
                      ),
                      DropdownMenuItem(
                        value: 'verbal',
                        child: Text('Explicación verbal'),
                      ),
                    ],
                    onChanged: (value) =>
                        setDialogState(() => preference = value ?? preference),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                await database.updateProfile(
                  age: int.tryParse(age.text) ?? 12,
                  grade: grade.text.trim(),
                  detectedLevel: level,
                  locale: locale,
                  learningPreference: preference,
                  defaultResponseDetail: ref.read(responseDetailProvider).name,
                );
                if (dialogContext.mounted) Navigator.pop(dialogContext);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
    age.dispose();
    grade.dispose();
  }

  Future<void> _showVoiceDialog() async {
    final tts = ref.read(ttsProvider);
    final voices = await tts.getVoices();
    if (!mounted) return;
    var selected = tts.activeVoice ?? (voices.isEmpty ? null : voices.first);
    var rate = tts.speechRate;
    var pitch = tts.speechPitch;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Voz y narración'),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: selected == null
                      ? null
                      : '${selected!.name}|${selected!.locale}',
                  decoration: const InputDecoration(
                    labelText: 'Voz instalada en el sistema',
                  ),
                  items: voices
                      .map(
                        (voice) => DropdownMenuItem(
                          value: '${voice.name}|${voice.locale}',
                          child: Text(
                            voice.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setDialogState(() {
                    selected = voices.firstWhere(
                      (voice) => '${voice.name}|${voice.locale}' == value,
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Text('Velocidad: ${rate.toStringAsFixed(2)}'),
                Slider(
                  value: rate,
                  min: 0.30,
                  max: 0.75,
                  divisions: 18,
                  onChanged: (v) => setDialogState(() => rate = v),
                ),
                Text('Tono: ${pitch.toStringAsFixed(2)}'),
                Slider(
                  value: pitch,
                  min: 0.75,
                  max: 1.25,
                  divisions: 10,
                  onChanged: (v) => setDialogState(() => pitch = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            OutlinedButton(
              onPressed: () => tts.speak(
                'Hola, soy Khipu. Así escucharás las explicaciones.',
              ),
              child: const Text('Probar'),
            ),
            FilledButton(
              onPressed: () async {
                await tts.configure(
                  name: selected?.name,
                  locale: selected?.locale,
                  rate: rate,
                  pitch: pitch,
                );
                await ref
                    .read(databaseProvider)
                    .updateVoice(
                      name: selected?.name,
                      locale: selected?.locale ?? 'es-PE',
                      rate: rate,
                      pitch: pitch,
                    );
                if (dialogContext.mounted) Navigator.pop(dialogContext);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNotebook() async {
    final database = ref.read(databaseProvider);
    final course = await database.courseForTitle(
      ref.read(pizarraContextProvider),
    );
    final suggestedTopic = course.title.contains('·')
        ? course.title.split('·').last.trim()
        : course.title;
    final title = TextEditingController(text: 'Mi cuaderno de $suggestedTopic');
    final topic = TextEditingController(text: suggestedTopic);
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nuevo cuaderno'),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  labelText: 'Nombre del cuaderno',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: topic,
                decoration: const InputDecoration(labelText: 'Tema'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final notebook = await database.ensureNotebookForCourse(
                course.id,
                title: title.text.trim().isEmpty
                    ? 'Mi cuaderno'
                    : title.text.trim(),
                topic: topic.text.trim().isEmpty
                    ? suggestedTopic
                    : topic.text.trim(),
              );
              final chat = await database.createChat(
                notebook.id,
                'Nueva conversación',
              );
              ref.read(activeChatIdProvider.notifier).set(chat.id);
              if (dialogContext.mounted) Navigator.pop(dialogContext);
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
    title.dispose();
    topic.dispose();
  }

  Future<void> _showHistoryLibrary() async {
    final database = ref.read(databaseProvider);
    final course = await database.courseForTitle(
      ref.read(pizarraContextProvider),
    );
    final notebooks = await database.getNotebooks(course.id);
    final records = await Future.wait(
      notebooks.map(
        (notebook) async => (notebook, await database.getChats(notebook.id)),
      ),
    );
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Cuadernos · ${course.subject}'),
        content: SizedBox(
          width: 520,
          height: 420,
          child: records.isEmpty
              ? const Center(
                  child: Text('Aún no hay cuadernos. Crea el primero.'),
                )
              : ListView(
                  children: [
                    for (final (notebook, chats) in records)
                      ExpansionTile(
                        leading: const Icon(Icons.menu_book_outlined),
                        title: Text(notebook.title),
                        subtitle: Text(notebook.topic),
                        trailing: IconButton(
                          tooltip: 'Nuevo chat',
                          icon: const Icon(Icons.add_comment_outlined),
                          onPressed: () async {
                            final chat = await database.createChat(
                              notebook.id,
                              'Nueva conversación',
                            );
                            ref
                                .read(activeChatIdProvider.notifier)
                                .set(chat.id);
                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);
                            }
                          },
                        ),
                        children: [
                          for (final chat in chats)
                            ListTile(
                              leading: const Icon(Icons.chat_bubble_outline),
                              title: Text(chat.title),
                              subtitle: Text(
                                chat.updatedAt.toLocal().toString().substring(
                                  0,
                                  16,
                                ),
                              ),
                              selected:
                                  ref.read(activeChatIdProvider) == chat.id,
                              onTap: () {
                                ref
                                    .read(activeChatIdProvider.notifier)
                                    .set(chat.id);
                                Navigator.pop(dialogContext);
                              },
                            ),
                        ],
                      ),
                  ],
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cerrar'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(dialogContext);
              _createNotebook();
            },
            icon: const Icon(Icons.create_new_folder_outlined),
            label: const Text('Nuevo cuaderno'),
          ),
        ],
      ),
    );
  }

  void _showModelMenu() {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (kIsWeb)
                ListTile(
                  leading: const Icon(Icons.computer_rounded),
                  title: const Text('Conectar modelo local (Chrome)'),
                  subtitle: const Text('Lee el .litertlm de la carpeta models'),
                  onTap: () {
                    Navigator.pop(ctx);
                    _installModelLocalWeb();
                  },
                ),
              if (!kIsWeb)
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
                        : () =>
                              ref.read(attachedImageProvider.notifier).clear(),
                    icon: const Icon(Icons.close, size: 18),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Respuesta:',
                  style: KhipuTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SegmentedButton<ResponseDetail>(
                    segments: const [
                      ButtonSegment(
                        value: ResponseDetail.simple,
                        label: Text('Simple'),
                      ),
                      ButtonSegment(
                        value: ResponseDetail.standard,
                        label: Text('Estándar'),
                      ),
                      ButtonSegment(
                        value: ResponseDetail.detailed,
                        label: Text('Detallada'),
                      ),
                    ],
                    selected: {ref.watch(responseDetailProvider)},
                    onSelectionChanged: busy
                        ? null
                        : (value) => ref
                              .read(responseDetailProvider.notifier)
                              .set(value.first),
                    showSelectedIcon: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                  onPressed: busy ? null : _showProfileDialog,
                  icon: const Icon(Icons.person_outline_rounded),
                  tooltip: 'Perfil del estudiante',
                ),
                IconButton(
                  onPressed: busy ? null : _showVoiceDialog,
                  icon: const Icon(Icons.record_voice_over_outlined),
                  tooltip: 'Configurar voz',
                ),
                IconButton(
                  onPressed: busy ? null : _showHistoryLibrary,
                  icon: const Icon(Icons.history_edu_outlined),
                  tooltip: 'Cuadernos e historial',
                ),
                IconButton(
                  onPressed: busy ? null : _createNotebook,
                  icon: const Icon(Icons.create_new_folder_outlined),
                  tooltip: 'Nuevo cuaderno',
                ),
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
    final profile = ref.watch(studentProfileProvider);
    final turns = ref.watch(activeChatTurnsProvider);
    final tts = ref.watch(ttsProvider);

    return SingleChildScrollView(
      child: Column(
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
            title: 'Perfil usado por la IA',
            child: profile.when(
              data: (p) => Text(
                '${p.age} años · ${p.grade}\n'
                'Nivel ${p.detectedLevel} · ${p.locale}\n'
                'Preferencia: ${p.learningPreference}\n'
                'Voz: ${tts.activeVoice?.toString() ?? 'automática del sistema'}',
                style: KhipuTextStyles.body.copyWith(fontSize: 12.5),
              ),
              loading: () => const Text('Cargando perfil…'),
              error: (_, _) => const Text('Perfil no disponible'),
            ),
          ),
          const SizedBox(height: 16),
          _PanelCard(
            title: 'Historial de este chat',
            child: turns.when(
              data: (items) => items.isEmpty
                  ? const Text('Las explicaciones aparecerán aquí.')
                  : Column(
                      children: [
                        for (final turn in items.reversed.take(5))
                          Material(
                            color: Colors.transparent,
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                turn.status == 'completed'
                                    ? Icons.play_circle_outline
                                    : Icons.pending_outlined,
                                color: KhipuColors.primary,
                              ),
                              title: Text(
                                turn.userQuestion.isEmpty
                                    ? 'Ejercicio con imagen'
                                    : turn.userQuestion,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                '${turn.responseDetail} · ${turn.engine}',
                              ),
                              enabled: !busy && turn.status == 'completed',
                              onTap: () => ref
                                  .read(lessonUiProvider.notifier)
                                  .replay(turn),
                            ),
                          ),
                      ],
                    ),
              loading: () => const Text('Cargando historial…'),
              error: (_, _) => const Text('No se pudo leer el historial'),
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
          const SizedBox(height: 8),
        ],
      ),
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
