import 'dart:ui';

import 'lesson_action.dart';

class BoardElement {
  const BoardElement({
    required this.id,
    required this.kind,
    required this.x,
    required this.y,
    this.text,
    this.width = 40,
    this.height = 40,
    this.color = const Color(0xFF1B4332),
    this.fontSize = 22,
    this.highlighted = false,
    this.highlightColor = const Color(0xFFF4A261),
    this.toX,
    this.toY,
    this.strokeWidth = 3,
  });

  final String id;
  final BoardElementKind kind;
  final double x;
  final double y;
  final String? text;
  final double width;
  final double height;
  final Color color;
  final double fontSize;
  final bool highlighted;
  final Color highlightColor;
  final double? toX;
  final double? toY;
  final double strokeWidth;

  BoardElement copyWith({
    double? x,
    double? y,
    bool? highlighted,
    Color? highlightColor,
    String? text,
  }) {
    return BoardElement(
      id: id,
      kind: kind,
      x: x ?? this.x,
      y: y ?? this.y,
      text: text ?? this.text,
      width: width,
      height: height,
      color: color,
      fontSize: fontSize,
      highlighted: highlighted ?? this.highlighted,
      highlightColor: highlightColor ?? this.highlightColor,
      toX: toX,
      toY: toY,
      strokeWidth: strokeWidth,
    );
  }
}

enum BoardElementKind { text, circle, rect, line, arrow, timeline, concept }

class BoardState {
  const BoardState({
    this.elements = const [],
    this.socraticPrompt,
    this.lastSpeakCue,
    this.actionIndex = -1,
  });

  final List<BoardElement> elements;
  final String? socraticPrompt;
  final String? lastSpeakCue;
  final int actionIndex;

  BoardState copyWith({
    List<BoardElement>? elements,
    String? socraticPrompt,
    bool clearSocratic = false,
    String? lastSpeakCue,
    int? actionIndex,
  }) {
    return BoardState(
      elements: elements ?? this.elements,
      socraticPrompt:
          clearSocratic ? null : (socraticPrompt ?? this.socraticPrompt),
      lastSpeakCue: lastSpeakCue ?? this.lastSpeakCue,
      actionIndex: actionIndex ?? this.actionIndex,
    );
  }
}

Color parseHexColor(String hex, [Color fallback = const Color(0xFF1B4332)]) {
  var value = hex.trim();
  if (value.startsWith('#')) value = value.substring(1);
  if (value.length == 6) value = 'FF$value';
  final parsed = int.tryParse(value, radix: 16);
  if (parsed == null) return fallback;
  return Color(parsed);
}

/// Pure reducer: aplica una acción sobre el estado de pizarra.
class BoardReducer {
  const BoardReducer();

  BoardState apply(BoardState state, LessonAction action, int index) {
    final next = state.copyWith(actionIndex: index, clearSocratic: true);

    switch (action) {
      case WriteTextAction a:
        return next.copyWith(
          elements: [
            ...next.elements,
            BoardElement(
              id: a.id,
              kind: BoardElementKind.text,
              x: a.x,
              y: a.y,
              text: a.text,
              fontSize: a.fontSize,
              color: parseHexColor(a.color),
            ),
          ],
        );
      case DrawShapeAction a:
        final kind = switch (a.kind) {
          ShapeKind.circle => BoardElementKind.circle,
          ShapeKind.rect => BoardElementKind.rect,
          ShapeKind.line => BoardElementKind.line,
        };
        return next.copyWith(
          elements: [
            ...next.elements,
            BoardElement(
              id: a.id,
              kind: kind,
              x: a.x,
              y: a.y,
              width: a.width,
              height: a.height,
              color: parseHexColor(a.color, const Color(0xFF2D6A4F)),
              strokeWidth: a.strokeWidth,
              toX: a.kind == ShapeKind.line ? a.x + a.width : null,
              toY: a.kind == ShapeKind.line ? a.y + a.height : null,
            ),
          ],
        );
      case DrawArrowAction a:
        return next.copyWith(
          elements: [
            ...next.elements,
            BoardElement(
              id: a.id,
              kind: BoardElementKind.arrow,
              x: a.fromX,
              y: a.fromY,
              toX: a.toX,
              toY: a.toY,
              color: parseHexColor(a.color, const Color(0xFFD62828)),
            ),
          ],
        );
      case HighlightAction a:
        return next.copyWith(
          elements: next.elements
              .map(
                (e) => e.id == a.targetId
                    ? e.copyWith(
                        highlighted: true,
                        highlightColor: parseHexColor(
                          a.color,
                          const Color(0xFFF4A261),
                        ),
                      )
                    : e,
              )
              .toList(),
        );
      case MoveAction a:
        return next.copyWith(
          elements: next.elements
              .map(
                (e) => e.id == a.targetId
                    ? e.copyWith(x: a.toX, y: a.toY)
                    : e,
              )
              .toList(),
        );
      case EraseAction a:
        return next.copyWith(
          elements:
              next.elements.where((e) => e.id != a.targetId).toList(),
        );
      case TimelineAction a:
        return next.copyWith(
          elements: [
            ...next.elements,
            BoardElement(
              id: a.id,
              kind: BoardElementKind.timeline,
              x: a.x,
              y: a.y,
              width: a.width,
              text: a.label,
              color: const Color(0xFF1B4332),
            ),
          ],
        );
      case ConceptNodeAction a:
        return next.copyWith(
          elements: [
            ...next.elements,
            BoardElement(
              id: a.id,
              kind: BoardElementKind.concept,
              x: a.x,
              y: a.y,
              width: 120,
              height: 48,
              text: a.label,
              color: parseHexColor(a.color, const Color(0xFF40916C)),
            ),
          ],
        );
      case WaitAction():
        return next;
      case SpeakCueAction a:
        return next.copyWith(lastSpeakCue: a.text);
      case AskSocraticAction a:
        return next.copyWith(socraticPrompt: a.prompt);
    }
  }
}
