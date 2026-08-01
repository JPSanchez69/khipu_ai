import '../../domain/lesson_script/lesson_action.dart';
import '../../domain/lesson_script/lesson_script_parser.dart';

/// Fixtures P0 para demo sin modelo (y fallback de Gemma).
class LessonFixtures {
  LessonFixtures._();

  static final _parser = const LessonScriptParser();

  static LessonScript equation2x() => _parser.parse(_equation2xJson);

  static LessonScript wordProblem() => _parser.parse(_wordProblemJson);

  static LessonScript timelineDemo() => _parser.parse(_timelineJson);

  static LessonScript resolve(String question) {
    final q = question.toLowerCase();
    if (q.contains('dinosaur') ||
        q.contains('extingu') ||
        q.contains('meteor')) {
      return timelineDemo();
    }
    if (q.contains('manzana') ||
        q.contains('tiene') && q.contains('compra') ||
        q.contains('problema')) {
      return wordProblem();
    }
    // Default demo star: ecuación
    return equation2x();
  }
}

const _equation2xJson = r'''
{
  "schemaVersion": "0.1",
  "title": "Resolver 2x + 3 = 11",
  "subject": "matematicas",
  "actions": [
    {
      "type": "askSocratic",
      "id": "s1",
      "prompt": "¿Qué pasa si resto 3 a ambos lados de la ecuación?",
      "durationMs": 1200
    },
    {
      "type": "speakCue",
      "id": "sp1",
      "text": "Vamos a resolver juntos dos equis más tres igual a once."
    },
    {
      "type": "writeText",
      "id": "eq1",
      "text": "2x + 3 = 11",
      "x": 48,
      "y": 64,
      "fontSize": 28,
      "durationMs": 600
    },
    { "type": "wait", "id": "w1", "ms": 500 },
    {
      "type": "highlight",
      "id": "h1",
      "targetId": "eq1",
      "color": "#F4A261",
      "durationMs": 400
    },
    {
      "type": "speakCue",
      "id": "sp2",
      "text": "Primero quito el tres. Resto tres a ambos lados."
    },
    {
      "type": "drawArrow",
      "id": "ar1",
      "fromX": 130,
      "fromY": 100,
      "toX": 130,
      "toY": 150,
      "durationMs": 450
    },
    {
      "type": "writeText",
      "id": "eq2",
      "text": "2x + 3 - 3 = 11 - 3",
      "x": 48,
      "y": 160,
      "fontSize": 24,
      "durationMs": 650
    },
    { "type": "wait", "id": "w2", "ms": 450 },
    {
      "type": "writeText",
      "id": "eq3",
      "text": "2x = 8",
      "x": 48,
      "y": 220,
      "fontSize": 26,
      "durationMs": 500
    },
    {
      "type": "speakCue",
      "id": "sp3",
      "text": "Ahora divido ambos lados entre dos."
    },
    {
      "type": "drawArrow",
      "id": "ar2",
      "fromX": 90,
      "fromY": 250,
      "toX": 90,
      "toY": 300,
      "durationMs": 400
    },
    {
      "type": "writeText",
      "id": "eq4",
      "text": "x = 4",
      "x": 48,
      "y": 310,
      "fontSize": 30,
      "color": "#2D6A4F",
      "durationMs": 700
    },
    {
      "type": "highlight",
      "id": "h2",
      "targetId": "eq4",
      "color": "#95D5B2",
      "durationMs": 500
    },
    {
      "type": "speakCue",
      "id": "sp4",
      "text": "Listo. Equis vale cuatro. ¿Quieres un ejercicio parecido?"
    }
  ]
}
''';

const _wordProblemJson = r'''
{
  "schemaVersion": "0.1",
  "title": "Problema de manzanas",
  "subject": "matematicas",
  "actions": [
    {
      "type": "askSocratic",
      "id": "s1",
      "prompt": "Si Ana tiene 5 manzanas y compra 3 más, ¿qué operación usamos?",
      "durationMs": 1100
    },
    {
      "type": "speakCue",
      "id": "sp1",
      "text": "Pensemos el problema paso a paso."
    },
    {
      "type": "writeText",
      "id": "t1",
      "text": "Ana tiene 5",
      "x": 40,
      "y": 60,
      "fontSize": 24
    },
    {
      "type": "drawShape",
      "id": "c1",
      "kind": "circle",
      "x": 40,
      "y": 110,
      "width": 28,
      "height": 28,
      "color": "#D62828"
    },
    {
      "type": "drawShape",
      "id": "c2",
      "kind": "circle",
      "x": 80,
      "y": 110,
      "width": 28,
      "height": 28,
      "color": "#D62828"
    },
    {
      "type": "drawShape",
      "id": "c3",
      "kind": "circle",
      "x": 120,
      "y": 110,
      "width": 28,
      "height": 28,
      "color": "#D62828"
    },
    { "type": "wait", "id": "w1", "ms": 400 },
    {
      "type": "speakCue",
      "id": "sp2",
      "text": "Compra tres más. Sumamos."
    },
    {
      "type": "writeText",
      "id": "t2",
      "text": "5 + 3 = ?",
      "x": 40,
      "y": 180,
      "fontSize": 26
    },
    {
      "type": "drawArrow",
      "id": "a1",
      "fromX": 100,
      "fromY": 210,
      "toX": 100,
      "toY": 250
    },
    {
      "type": "writeText",
      "id": "t3",
      "text": "8 manzanas",
      "x": 40,
      "y": 270,
      "fontSize": 28,
      "color": "#2D6A4F"
    },
    {
      "type": "highlight",
      "id": "h1",
      "targetId": "t3"
    }
  ]
}
''';

const _timelineJson = r'''
{
  "schemaVersion": "0.1",
  "title": "Extinción de dinosaurios",
  "subject": "ciencias",
  "actions": [
    {
      "type": "askSocratic",
      "id": "s1",
      "prompt": "¿Qué crees que pasó primero: el impacto o la nube de polvo?",
      "durationMs": 1000
    },
    {
      "type": "speakCue",
      "id": "sp1",
      "text": "Construyamos la historia en una línea de tiempo."
    },
    {
      "type": "drawShape",
      "id": "earth",
      "kind": "circle",
      "x": 200,
      "y": 40,
      "width": 90,
      "height": 90,
      "color": "#2D6A4F",
      "durationMs": 500
    },
    {
      "type": "writeText",
      "id": "t0",
      "text": "Tierra",
      "x": 218,
      "y": 130,
      "fontSize": 16
    },
    {
      "type": "drawShape",
      "id": "meteor",
      "kind": "circle",
      "x": 40,
      "y": 20,
      "width": 24,
      "height": 24,
      "color": "#6C584C"
    },
    {
      "type": "drawArrow",
      "id": "impact",
      "fromX": 64,
      "fromY": 44,
      "toX": 210,
      "toY": 80,
      "color": "#D62828"
    },
    {
      "type": "speakCue",
      "id": "sp2",
      "text": "Un meteorito impactó. Luego una nube de polvo tapó el sol."
    },
    {
      "type": "timeline",
      "id": "tl1",
      "label": "1. Impacto",
      "x": 40,
      "y": 200,
      "width": 260
    },
    {
      "type": "timeline",
      "id": "tl2",
      "label": "2. Polvo y oscuridad",
      "x": 40,
      "y": 250,
      "width": 260
    },
    {
      "type": "timeline",
      "id": "tl3",
      "label": "3. Plantas y animales afectados",
      "x": 40,
      "y": 300,
      "width": 260
    },
    {
      "type": "conceptNode",
      "id": "n1",
      "label": "Extinción",
      "x": 160,
      "y": 360,
      "color": "#BC4749"
    }
  ]
}
''';
