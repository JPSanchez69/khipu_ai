import 'dart:async';

import '../domain/lesson_script/board_state.dart';
import '../domain/lesson_script/lesson_action.dart';
import '../domain/ports/voice_ports.dart';

typedef BoardListener = void Function(BoardState state);

/// Reproduce LessonScript sincronizando pizarra + TTS (con await de voz).
class LessonPlayer {
  LessonPlayer({
    required this._reducer,
    required this._tts,
  });

  final BoardReducer _reducer;
  final TtsPort _tts;

  var _playing = false;
  var _cancelled = false;

  bool get isPlaying => _playing;

  Future<void> play(
    LessonScript script, {
    required BoardListener onBoard,
    void Function(String message)? onStatus,
  }) async {
    if (_playing) return;
    _playing = true;
    _cancelled = false;
    var state = const BoardState();
    onBoard(state);

    try {
      for (var i = 0; i < script.actions.length; i++) {
        if (_cancelled) break;
        final action = script.actions[i];
        state = _reducer.apply(state, action, i);
        onBoard(state);

        switch (action) {
          case SpeakCueAction a:
            onStatus?.call(a.text);
            await _tts.speak(a.text);
          case AskSocraticAction a:
            onStatus?.call(a.prompt);
            await _tts.speak(a.prompt);
            if (!_cancelled && action.durationMs > 0) {
              await Future<void>.delayed(
                Duration(milliseconds: action.durationMs.clamp(0, 2500)),
              );
            }
          default:
            if (action.durationMs > 0) {
              await Future<void>.delayed(
                Duration(milliseconds: action.durationMs.clamp(0, 3000)),
              );
            }
        }
      }
    } finally {
      _playing = false;
    }
  }

  Future<void> stop() async {
    _cancelled = true;
    await _tts.stop();
  }
}
