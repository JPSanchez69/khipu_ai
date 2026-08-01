/// LessonScript DSL v0.1 — acciones de pizarra pedagógica.
library;

enum ShapeKind { circle, rect, line }

sealed class LessonAction {
  const LessonAction({required this.id, this.durationMs = 400});

  final String id;
  final int durationMs;
}

final class WriteTextAction extends LessonAction {
  const WriteTextAction({
    required super.id,
    required this.text,
    required this.x,
    required this.y,
    this.fontSize = 22,
    this.color = '#1B4332',
    super.durationMs = 500,
  });

  final String text;
  final double x;
  final double y;
  final double fontSize;
  final String color;
}

final class DrawShapeAction extends LessonAction {
  const DrawShapeAction({
    required super.id,
    required this.kind,
    required this.x,
    required this.y,
    this.width = 40,
    this.height = 40,
    this.color = '#2D6A4F',
    this.strokeWidth = 3,
    super.durationMs = 400,
  });

  final ShapeKind kind;
  final double x;
  final double y;
  final double width;
  final double height;
  final String color;
  final double strokeWidth;
}

final class DrawArrowAction extends LessonAction {
  const DrawArrowAction({
    required super.id,
    required this.fromX,
    required this.fromY,
    required this.toX,
    required this.toY,
    this.color = '#D62828',
    super.durationMs = 450,
  });

  final double fromX;
  final double fromY;
  final double toX;
  final double toY;
  final String color;
}

final class HighlightAction extends LessonAction {
  const HighlightAction({
    required super.id,
    required this.targetId,
    this.color = '#F4A261',
    super.durationMs = 350,
  });

  final String targetId;
  final String color;
}

final class MoveAction extends LessonAction {
  const MoveAction({
    required super.id,
    required this.targetId,
    required this.toX,
    required this.toY,
    super.durationMs = 500,
  });

  final String targetId;
  final double toX;
  final double toY;
}

final class EraseAction extends LessonAction {
  const EraseAction({
    required super.id,
    required this.targetId,
    super.durationMs = 200,
  });

  final String targetId;
}

final class TimelineAction extends LessonAction {
  const TimelineAction({
    required super.id,
    required this.label,
    required this.x,
    required this.y,
    this.width = 280,
    super.durationMs = 400,
  });

  final String label;
  final double x;
  final double y;
  final double width;
}

final class ConceptNodeAction extends LessonAction {
  const ConceptNodeAction({
    required super.id,
    required this.label,
    required this.x,
    required this.y,
    this.color = '#40916C',
    super.durationMs = 400,
  });

  final String label;
  final double x;
  final double y;
  final String color;
}

final class WaitAction extends LessonAction {
  const WaitAction({
    required super.id,
    required int ms,
  }) : super(durationMs: ms);
}

final class SpeakCueAction extends LessonAction {
  const SpeakCueAction({
    required super.id,
    required this.text,
    super.durationMs = 0,
  });

  final String text;
}

final class AskSocraticAction extends LessonAction {
  const AskSocraticAction({
    required super.id,
    required this.prompt,
    super.durationMs = 800,
  });

  final String prompt;
}

class LessonScript {
  const LessonScript({
    required this.schemaVersion,
    required this.title,
    required this.actions,
    this.subject = 'general',
  });

  final String schemaVersion;
  final String title;
  final String subject;
  final List<LessonAction> actions;
}
