import 'lesson_action.dart';
import 'lesson_script_parser.dart';

/// Valida que un LessonScript sea jugable en pizarra + voz (MVP 1B).
class LessonScriptQuality {
  LessonScriptQuality._();

  /// Exige ≥1 [SpeakCueAction] con texto y ≥1 [WriteTextAction] con texto.
  /// Lanza [LessonScriptParseException] si es solo chat o pizarra muda.
  static void ensurePlayable(LessonScript script) {
    final hasSpeak = script.actions.any(
      (a) => a is SpeakCueAction && a.text.trim().isNotEmpty,
    );
    final hasWrite = script.actions.any(
      (a) => a is WriteTextAction && a.text.trim().isNotEmpty,
    );
    if (!hasSpeak || !hasWrite) {
      throw LessonScriptParseException(
        'Lección incompleta: se necesita speakCue y writeText',
      );
    }
  }
}
