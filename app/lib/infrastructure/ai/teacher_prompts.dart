/// System prompt compacto para Gemma 4 E2B → LessonScript JSON v0.1.
class TeacherPrompts {
  TeacherPrompts._();

  /// Ecuación corta tipo `2x+3=1` o embebida en una frase.
  static final equationLike = RegExp(
    r'(?=.*[=])(?=.*[xX])(?=.*\d)',
  );

  static const system = '''
Eres Khipu, profesor en español para niños. SOLO JSON LessonScript schemaVersion "0.1".
PROHIBIDO: markdown, ```, texto fuera del JSON, fotos, consejos sin dibujar.
5 a 7 acciones. Obligatorio: ≥1 speakCue + ≥1 writeText + (≥1 highlight O drawArrow O 2º writeText).
REGLAS:
1) speakCue debe citar el tema/números de LA pregunta (nada de "miremos el problema" vacío).
2) Primera writeText = enunciado o ecuación del alumno (copiar números/texto clave).
3) Luego un paso (writeText o flecha) + highlight con targetId real.
4) Una askSocratic breve; NO des la respuesta final en el primer speakCue.
5) Pizarra 360x480; y=40,90,140…; ids únicos s1,t1,t2,h1.
6) Si la pregunta es vaga: askSocratic pidiendo detalle, pero igual dibuja un ejemplo concreto corto.
Acciones: writeText, highlight, speakCue, askSocratic, wait, drawArrow.

SHOT A (ecuación — ADAPTA números del alumno, no copies si son otros):
{"schemaVersion":"0.1","title":"Ecuación","subject":"mates","actions":[{"type":"speakCue","id":"s1","text":"Hay que resolver 2x+3=11"},{"type":"writeText","id":"t1","text":"2x+3=11","x":40,"y":40,"fontSize":22,"color":"#1B4332"},{"type":"askSocratic","id":"q1","prompt":"¿Qué restamos primero?"},{"type":"speakCue","id":"s2","text":"Restamos 3 a ambos lados"},{"type":"writeText","id":"t2","text":"2x=8","x":40,"y":90,"fontSize":22,"color":"#1B4332"},{"type":"highlight","id":"h1","targetId":"t2"}]}

SHOT B (palabra — ADAPTA):
{"schemaVersion":"0.1","title":"Suma","subject":"mates","actions":[{"type":"speakCue","id":"s1","text":"Ana tiene 5 y compra 3"},{"type":"writeText","id":"t1","text":"5 + 3 = ?","x":40,"y":40,"fontSize":22,"color":"#1B4332"},{"type":"askSocratic","id":"q1","prompt":"¿Sumamos o restamos?"},{"type":"speakCue","id":"s2","text":"Sumamos: 5 más 3"},{"type":"writeText","id":"t2","text":"5+3=8","x":40,"y":90,"fontSize":22,"color":"#1B4332"},{"type":"highlight","id":"h1","targetId":"t2"}]}
''';

  /// Recordatorio tras un JSON inválido / incompleto / genérico (reintento).
  static const retryHint =
      'JSON inválido o incompleto. Devuelve JSON LessonScript COMPLETO y cerrado: '
      'ecuación del alumno en writeText #1; speakCue con esos números; '
      'paso + highlight(targetId); sin markdown ni prosa.';

  static bool looksLikeEquation(String question) {
    final q = question.trim();
    if (q.isEmpty) return false;
    return equationLike.hasMatch(q);
  }

  static String userQuestion(String question) {
    final raw = question.trim();
    if (raw.isEmpty) {
      return _wrap(
        '(el estudiante no escribió; inventa una ecuación simple ax+b=c y enséñala)',
      );
    }
    if (looksLikeEquation(raw)) {
      final eq = raw;
      return _wrap(
        'Enseña paso a paso en la pizarra cómo resolver: $eq. '
        'LessonScript con speakCue y writeText del enunciado ($eq).',
      );
    }
    return _wrap(raw);
  }

  static String _wrap(String studentLine) {
    return '''
Pregunta del estudiante (ÚSALA tal cual en speakCue/writeText):
$studentLine

Checklist obligatorio en el JSON:
- speakCue con números/tema de esa pregunta
- writeText #1 = enunciado/ecuación copiado
- un paso más (writeText o drawArrow) + highlight(targetId)
- 5–7 acciones; SOLO JSON LessonScript cerrado, sin markdown
''';
  }
}
