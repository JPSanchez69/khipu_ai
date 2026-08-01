import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../core/theme/khipu_theme.dart';
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
    if (q.isEmpty) return;
    _controller.text = q;
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

  @override
  Widget build(BuildContext context) {
    final ui = ref.watch(lessonUiProvider);
    final board = ref.watch(boardStateProvider);
    final useGemma = ref.watch(useGemmaProvider);
    final busy = ui.phase == LessonPhase.thinking ||
        ui.phase == LessonPhase.playing;

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
                  FilterChip(
                    label: Text(useGemma ? 'Gemma' : 'Stub'),
                    selected: useGemma,
                    onSelected: busy
                        ? null
                        : (v) => ref.read(useGemmaProvider.notifier).set(v),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Tu profesor en el bolsillo — sin internet',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: KhipuTheme.leaf,
                    ),
              ),
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
                    onPressed: busy || _listening ? null : _listen,
                    icon: Icon(_listening ? Icons.hearing : Icons.mic),
                    tooltip: 'Hablar',
                  ),
                  const SizedBox(width: 4),
                  if (busy)
                    IconButton.filled(
                      onPressed: () =>
                          ref.read(lessonUiProvider.notifier).stop(),
                      icon: const Icon(Icons.stop),
                    )
                  else
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
