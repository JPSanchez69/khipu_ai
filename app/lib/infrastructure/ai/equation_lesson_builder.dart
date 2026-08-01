import '../../domain/lesson_script/lesson_action.dart';

/// Lección mínima ax+b=c cuando Gemma no devuelve JSON jugable.
/// Solo para ecuaciones lineales simples detectables en el texto.
class EquationLessonBuilder {
  EquationLessonBuilder._();

  /// Patrón: `2x+3=1`, `x-4=10`, `-3x+5=2` (espacios opcionales).
  static final _eqPattern = RegExp(
    r'([+-]?\d*)[xX]([+-]\d+)?=([+-]?\d+)',
  );

  static String? extractEquation(String question) {
    final compact = question.replaceAll(RegExp(r'\s+'), '');
    final m = _eqPattern.firstMatch(compact);
    if (m == null) return null;
    return m.group(0);
  }

  /// null si no parece ax+b=c parseable.
  static LessonScript? tryBuild(String question) {
    final compact = question.replaceAll(RegExp(r'\s+'), '');
    final m = _eqPattern.firstMatch(compact);
    if (m == null) return null;

    final aRaw = m.group(1)!;
    final bRaw = m.group(2); // null o "+3" / "-3"
    final cRaw = m.group(3)!;

    final a = aRaw.isEmpty || aRaw == '+'
        ? 1
        : aRaw == '-'
            ? -1
            : int.tryParse(aRaw);
    final b = bRaw == null || bRaw.isEmpty
        ? 0
        : int.tryParse(bRaw.replaceAll('+', ''));
    final c = int.tryParse(cRaw);
    if (a == null || b == null || c == null || a == 0) return null;

    final eq = '${_fmtAx(a)}x${_fmtB(b)}=$c';
    final afterSub = c - b;
    final xVal = afterSub / a;
    final xText = xVal == xVal.roundToDouble()
        ? '${xVal.round()}'
        : xVal.toStringAsFixed(2);

    final step1 = b == 0 ? 'x=$xText' : '${_fmtAx(a)}x=$afterSub';
    final step2 = 'x=$xText';

    return LessonScript(
      schemaVersion: '0.1',
      title: 'Resolver $eq',
      subject: 'mates',
      actions: [
        SpeakCueAction(
          id: 's1',
          text: 'Vamos a resolver $eq',
        ),
        WriteTextAction(
          id: 't1',
          text: eq,
          x: 40,
          y: 40,
          fontSize: 22,
        ),
        AskSocraticAction(
          id: 'q1',
          prompt: b == 0
              ? '¿Qué hacemos con el coeficiente de x?'
              : '¿Qué restamos o sumamos primero en ambos lados?',
        ),
        SpeakCueAction(
          id: 's2',
          text: b == 0
              ? 'Dividimos ambos lados entre $a'
              : b > 0
                  ? 'Restamos $b a ambos lados'
                  : 'Sumamos ${-b} a ambos lados',
        ),
        WriteTextAction(
          id: 't2',
          text: step1,
          x: 40,
          y: 90,
          fontSize: 22,
        ),
        HighlightAction(id: 'h1', targetId: 't2'),
        if (b != 0) ...[
          SpeakCueAction(
            id: 's3',
            text: 'Luego dividimos entre $a y obtenemos $step2',
          ),
          WriteTextAction(
            id: 't3',
            text: step2,
            x: 40,
            y: 140,
            fontSize: 22,
          ),
        ],
      ],
    );
  }

  static String _fmtAx(int a) {
    if (a == 1) return '';
    if (a == -1) return '-';
    return '$a';
  }

  static String _fmtB(int b) {
    if (b == 0) return '';
    if (b > 0) return '+$b';
    return '$b';
  }
}
