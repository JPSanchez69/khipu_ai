import 'dart:convert';

import 'lesson_action.dart';

class LessonScriptParseException implements Exception {
  LessonScriptParseException(this.message);
  final String message;

  @override
  String toString() => 'LessonScriptParseException: $message';
}

/// Parses and lightly repairs LessonScript JSON v0.1.
class LessonScriptParser {
  const LessonScriptParser();

  LessonScript parse(String raw) {
    final cleaned = _extractJson(raw);
    late final Object? decoded;
    try {
      decoded = jsonDecode(cleaned);
    } on FormatException catch (e) {
      throw LessonScriptParseException('JSON inválido: ${e.message}');
    }

    if (decoded is! Map<String, dynamic>) {
      throw LessonScriptParseException('La raíz debe ser un objeto JSON');
    }

    return fromMap(decoded);
  }

  /// Best-effort repair: extract first `{...}` block from model output.
  LessonScript parseLenient(String raw) {
    try {
      return parse(raw);
    } on LessonScriptParseException {
      final repaired = _extractJson(raw);
      return parse(repaired);
    }
  }

  LessonScript fromMap(Map<String, dynamic> map) {
    final version = (map['schemaVersion'] ?? map['schema_version'] ?? '0.1')
        .toString();
    if (version != '0.1') {
      throw LessonScriptParseException(
        'schemaVersion no soportado: $version (esperado 0.1)',
      );
    }

    final title = (map['title'] ?? 'Lección').toString();
    final subject = (map['subject'] ?? 'general').toString();
    final rawActions = map['actions'];
    if (rawActions is! List) {
      throw LessonScriptParseException('actions debe ser una lista');
    }

    final actions = <LessonAction>[];
    for (var i = 0; i < rawActions.length; i++) {
      final item = rawActions[i];
      if (item is! Map) {
        continue;
      }
      final action = _parseAction(Map<String, dynamic>.from(item), i);
      if (action != null) {
        actions.add(action);
      }
    }

    if (actions.isEmpty) {
      throw LessonScriptParseException('La lección no tiene acciones válidas');
    }

    return LessonScript(
      schemaVersion: version,
      title: title,
      subject: subject,
      actions: actions,
    );
  }

  LessonAction? _parseAction(Map<String, dynamic> map, int index) {
    final type = (map['type'] ?? map['action'] ?? '').toString();
    final id = (map['id'] ?? 'a$index').toString();
    final duration = _asInt(map['durationMs'] ?? map['duration_ms'], 400);

    switch (type) {
      case 'writeText':
      case 'write_text':
        return WriteTextAction(
          id: id,
          text: (map['text'] ?? '').toString(),
          x: _asDouble(map['x'], 40),
          y: _asDouble(map['y'], 40),
          fontSize: _asDouble(map['fontSize'] ?? map['font_size'], 22),
          color: (map['color'] ?? '#1B4332').toString(),
          durationMs: duration,
        );
      case 'drawShape':
      case 'draw_shape':
        return DrawShapeAction(
          id: id,
          kind: _shapeKind(map['kind'] ?? map['shape']),
          x: _asDouble(map['x'], 40),
          y: _asDouble(map['y'], 40),
          width: _asDouble(map['width'], 40),
          height: _asDouble(map['height'], 40),
          color: (map['color'] ?? '#2D6A4F').toString(),
          strokeWidth: _asDouble(map['strokeWidth'] ?? map['stroke_width'], 3),
          durationMs: duration,
        );
      case 'drawArrow':
      case 'draw_arrow':
        return DrawArrowAction(
          id: id,
          fromX: _asDouble(map['fromX'] ?? map['from_x'], 0),
          fromY: _asDouble(map['fromY'] ?? map['from_y'], 0),
          toX: _asDouble(map['toX'] ?? map['to_x'], 100),
          toY: _asDouble(map['toY'] ?? map['to_y'], 100),
          color: (map['color'] ?? '#D62828').toString(),
          durationMs: duration,
        );
      case 'highlight':
        return HighlightAction(
          id: id,
          targetId: (map['targetId'] ?? map['target_id'] ?? '').toString(),
          color: (map['color'] ?? '#F4A261').toString(),
          durationMs: duration,
        );
      case 'move':
        return MoveAction(
          id: id,
          targetId: (map['targetId'] ?? map['target_id'] ?? '').toString(),
          toX: _asDouble(map['toX'] ?? map['to_x'], 0),
          toY: _asDouble(map['toY'] ?? map['to_y'], 0),
          durationMs: duration,
        );
      case 'erase':
        return EraseAction(
          id: id,
          targetId: (map['targetId'] ?? map['target_id'] ?? '').toString(),
          durationMs: duration,
        );
      case 'timeline':
        return TimelineAction(
          id: id,
          label: (map['label'] ?? '').toString(),
          x: _asDouble(map['x'], 40),
          y: _asDouble(map['y'], 200),
          width: _asDouble(map['width'], 280),
          durationMs: duration,
        );
      case 'conceptNode':
      case 'concept_node':
        return ConceptNodeAction(
          id: id,
          label: (map['label'] ?? '').toString(),
          x: _asDouble(map['x'], 40),
          y: _asDouble(map['y'], 40),
          color: (map['color'] ?? '#40916C').toString(),
          durationMs: duration,
        );
      case 'wait':
      case 'pause':
        return WaitAction(
          id: id,
          ms: _asInt(map['ms'] ?? map['durationMs'], duration),
        );
      case 'speakCue':
      case 'speak_cue':
      case 'speak':
        return SpeakCueAction(
          id: id,
          text: (map['text'] ?? '').toString(),
          durationMs: duration,
        );
      case 'askSocratic':
      case 'ask_socratic':
      case 'socratic':
        return AskSocraticAction(
          id: id,
          prompt: (map['prompt'] ?? map['text'] ?? '').toString(),
          durationMs: duration,
        );
      default:
        return null;
    }
  }

  ShapeKind _shapeKind(Object? raw) {
    switch ((raw ?? 'circle').toString().toLowerCase()) {
      case 'rect':
      case 'rectangle':
        return ShapeKind.rect;
      case 'line':
        return ShapeKind.line;
      default:
        return ShapeKind.circle;
    }
  }

  String _extractJson(String raw) {
    final trimmed = raw.trim();
    if (trimmed.startsWith('{')) {
      return trimmed;
    }
    final start = trimmed.indexOf('{');
    final end = trimmed.lastIndexOf('}');
    if (start >= 0 && end > start) {
      return trimmed.substring(start, end + 1);
    }
    // Fence markdown
    final fence = RegExp(r'```(?:json)?\s*([\s\S]*?)```', multiLine: true);
    final match = fence.firstMatch(trimmed);
    if (match != null) {
      return match.group(1)!.trim();
    }
    return trimmed;
  }

  double _asDouble(Object? value, double fallback) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? fallback;
    return fallback;
  }

  int _asInt(Object? value, int fallback) {
    if (value is num) return value.round();
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }
}
