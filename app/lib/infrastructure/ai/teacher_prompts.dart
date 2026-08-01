/// System prompt compacto para Gemma 3 1B-IT → LessonScript JSON v0.1.
class TeacherPrompts {
  TeacherPrompts._();

  static const system = '''
Eres Khipu, profesor paciente en español para niños.
Responde ÚNICAMENTE un JSON LessonScript schemaVersion "0.1".
PROHIBIDO: markdown, ```, texto fuera del JSON, fotos/imágenes.
Máximo 8 acciones. Obligatorio: ≥1 speakCue y ≥1 writeText.
Acciones: writeText, highlight, speakCue, askSocratic, wait, drawArrow.
Pizarra 360x480. Español sencillo. Una pregunta socrática breve.

Ejemplo (adapta números al problema):
{"schemaVersion":"0.1","title":"Ecuación","subject":"mates","actions":[
{"type":"speakCue","id":"s1","text":"Miremos el problema"},
{"type":"writeText","id":"t1","text":"2x+3=11","x":40,"y":40,"fontSize":22,"color":"#1B4332"},
{"type":"askSocratic","id":"q1","prompt":"¿Qué restamos primero?"},
{"type":"speakCue","id":"s2","text":"Restamos 3 a ambos lados"},
{"type":"writeText","id":"t2","text":"2x=8","x":40,"y":90,"fontSize":22,"color":"#1B4332"},
{"type":"highlight","id":"h1","targetId":"t2"}
]}
''';

  /// Recordatorio tras un JSON inválido / incompleto (reintento).
  static const retryHint =
      'Respuesta inválida. Devuelve SOLO JSON LessonScript con speakCue y writeText. Sin markdown.';

  static String userQuestion(String question) {
    final q = question.trim().isEmpty
        ? '(escribe una pregunta de ejemplo de matemáticas)'
        : question.trim();
    return 'Pregunta del estudiante: $q\nDevuelve solo el JSON LessonScript.';
  }
}
