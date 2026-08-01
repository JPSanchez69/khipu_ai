import 'dart:convert';

import 'lesson_action.dart';
import 'lesson_script_parser.dart';

class LessonScriptCodec {
  const LessonScriptCodec();

  String encode(LessonScript script) => jsonEncode({
    'schemaVersion': script.schemaVersion,
    'title': script.title,
    'subject': script.subject,
    'actions': script.actions.map(_actionToMap).toList(),
  });

  LessonScript decode(String source) =>
      const LessonScriptParser().parse(source);

  String narration(LessonScript script) => script.actions
      .map(
        (a) => switch (a) {
          SpeakCueAction(:final text) => text,
          AskSocraticAction(:final prompt) => prompt,
          _ => '',
        },
      )
      .where((text) => text.trim().isNotEmpty)
      .join('\n');

  Map<String, Object> _actionToMap(LessonAction action) {
    final base = <String, Object>{
      'id': action.id,
      'durationMs': action.durationMs,
    };
    return switch (action) {
      WriteTextAction a => {
        ...base,
        'type': 'writeText',
        'text': a.text,
        'x': a.x,
        'y': a.y,
        'fontSize': a.fontSize,
        'color': a.color,
      },
      DrawShapeAction a => {
        ...base,
        'type': 'drawShape',
        'kind': a.kind.name,
        'x': a.x,
        'y': a.y,
        'width': a.width,
        'height': a.height,
        'color': a.color,
        'strokeWidth': a.strokeWidth,
      },
      DrawArrowAction a => {
        ...base,
        'type': 'drawArrow',
        'fromX': a.fromX,
        'fromY': a.fromY,
        'toX': a.toX,
        'toY': a.toY,
        'color': a.color,
      },
      HighlightAction a => {
        ...base,
        'type': 'highlight',
        'targetId': a.targetId,
        'color': a.color,
      },
      MoveAction a => {
        ...base,
        'type': 'move',
        'targetId': a.targetId,
        'toX': a.toX,
        'toY': a.toY,
      },
      EraseAction a => {...base, 'type': 'erase', 'targetId': a.targetId},
      TimelineAction a => {
        ...base,
        'type': 'timeline',
        'label': a.label,
        'x': a.x,
        'y': a.y,
        'width': a.width,
      },
      ConceptNodeAction a => {
        ...base,
        'type': 'conceptNode',
        'label': a.label,
        'x': a.x,
        'y': a.y,
        'color': a.color,
      },
      WaitAction _ => {...base, 'type': 'wait', 'ms': action.durationMs},
      SpeakCueAction a => {...base, 'type': 'speakCue', 'text': a.text},
      AskSocraticAction a => {
        ...base,
        'type': 'askSocratic',
        'prompt': a.prompt,
      },
    };
  }
}
