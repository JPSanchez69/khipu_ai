# Khipu AI

Profesor inteligente **offline** en Android: Gemma on-device + pizarra pedagógica (LessonScript).

## Docs

- [Blueprint](docs/BLUEPRINT.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Demo script](docs/DEMO.md)
- [Gemma setup](docs/GEMMA_SETUP.md)
- [Prompt MVP](docs/PROMPT_MVP.md)
- [LessonScript schema](docs/lesson_script_v0.1.schema.json)

## Arranque

```bash
# Flutter en PATH (p. ej. %USERPROFILE%\flutter\bin)
cd app
flutter pub get
flutter test
flutter run -d chrome          # demo UI sin Android SDK
flutter run                    # Android (requiere SDK + minSdk 26)
```

Por defecto usa **StubTeacher** (fixtures). Activa el chip **Gemma** en la UI cuando el modelo esté instalado.

## Qué incluye el MVP

| Prioridad | Entrega |
|-----------|---------|
| P0 | Texto → lección + pizarra Canvas + TTS + LessonScript DSL + stub/Gemma port |
| P1 | Micrófono STT (JARVIS-lite) sincronizado con el flujo de lección |
| P2 | Foto/PDF — no implementado (cortado a propósito) |

## Estructura

```
khipu_ai/                 # repo
  docs/                  # producto / arquitectura
  app/                   # Flutter (package: khipu_ai)
    lib/
      core/
      domain/
      application/
      infrastructure/
      features/
```
