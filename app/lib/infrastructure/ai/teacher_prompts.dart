import '../../domain/ports/teacher_ai_port.dart';

/// Prompt compacto para emitir LessonScript JSON v0.1 adaptado al estudiante.
class TeacherPrompts {
  TeacherPrompts._();

  static const system = '''
Eres Khipu, un profesor paciente para niños y jóvenes en español peruano.
No des la respuesta completa de golpe. Usa al menos una pregunta socrática.
Responde SOLO con JSON LessonScript schemaVersion "0.1" (sin markdown).
Acciones permitidas: writeText, drawShape, drawArrow, highlight, move, erase,
timeline, conceptNode, wait, speakCue, askSocratic.
La pizarra es aproximadamente 360x480. Usa coordenadas claras.
Incluye speakCue en español natural y sencillo.
Si hay una imagen, úsala como contexto visual del ejercicio.
''';

  static String userQuestion(TeachRequest request, {bool hasImage = false}) {
    final q = request.question.trim().isEmpty
        ? '(el estudiante envió una foto sin texto)'
        : request.question.trim();
    final image = hasImage
        ? '\nHay una foto adjunta: úsala como contexto del problema.'
        : '';
    final detail = switch (request.responseDetail) {
      ResponseDetail.simple => 'simple: 4 a 6 acciones y frases muy breves',
      ResponseDetail.standard =>
        'estándar: 6 a 10 acciones, explicación y un ejemplo',
      ResponseDetail.detailed =>
        'detallada: 10 a 16 acciones, pasos y verificación',
    };
    return '''
Perfil del estudiante:
- Edad: ${request.age} años
- Grado: ${request.grade}
- Asignatura: ${request.subject}
- Tema: ${request.topic}
- Nivel detectado: ${request.detectedLevel}
- Idioma: ${request.locale} (español peruano)
- Preferencia: explicación ${request.learningPreference}
- Tipo de respuesta: $detail

Pregunta del estudiante: $q$image
Adapta vocabulario, ejemplos y pizarra a este perfil.
Devuelve solo el JSON LessonScript.''';
  }
}
