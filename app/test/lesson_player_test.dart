import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/application/lesson_player.dart';
import 'package:khipu_ai/domain/lesson_script/board_state.dart';
import 'package:khipu_ai/domain/lesson_script/lesson_action.dart';
import 'package:khipu_ai/domain/ports/voice_ports.dart';

class _FakeTts implements TtsPort {
  final spoken = <String>[];

  @override
  Future<void> speak(String text) async {
    spoken.add(text);
  }

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {}
}

void main() {
  test('álgebra: write/highlight en board + speakCue en TTS', () async {
    final tts = _FakeTts();
    final player = LessonPlayer(reducer: const BoardReducer(), tts: tts);
    BoardState? last;

    const script = LessonScript(
      schemaVersion: '0.1',
      title: 'Resolver 2x+3=11',
      subject: 'mates',
      actions: [
        SpeakCueAction(id: 's1', text: 'Miremos el problema'),
        WriteTextAction(id: 't1', text: '2x+3=11', x: 40, y: 40),
        HighlightAction(id: 'h1', targetId: 't1'),
        SpeakCueAction(id: 's2', text: 'Restamos 3 a ambos lados'),
        WriteTextAction(id: 't2', text: '2x=8', x: 40, y: 90),
      ],
    );

    await player.play(script, onBoard: (b) => last = b);

    expect(tts.spoken, contains('Miremos el problema'));
    expect(tts.spoken, contains('Restamos 3 a ambos lados'));
    expect(last, isNotNull);
    expect(last!.elements.where((e) => e.kind == BoardElementKind.text).length,
        greaterThanOrEqualTo(2));
    expect(last!.elements.any((e) => e.highlighted), isTrue);
  });

  test('fallo de TTS no aborta el resto de la lección', () async {
    final player = LessonPlayer(
      reducer: const BoardReducer(),
      tts: _ThrowingTts(),
    );
    BoardState? last;

    const script = LessonScript(
      schemaVersion: '0.1',
      title: 'T',
      subject: 'mates',
      actions: [
        SpeakCueAction(id: 's1', text: 'Hola'),
        WriteTextAction(id: 't1', text: '2x', x: 10, y: 10),
      ],
    );

    await player.play(script, onBoard: (b) => last = b);
    expect(last!.elements, isNotEmpty);
  });
}

class _ThrowingTts implements TtsPort {
  @override
  Future<void> speak(String text) async {
    throw StateError('tts down');
  }

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {}
}
