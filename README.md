# Khipu AI

Profesor inteligente **offline** en Android: Gemma 3 1B-IT on-device + pizarra pedagógica (LessonScript).

## Docs

- [Cómo correr el proyecto](docs/RUNNING.md)
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

Por defecto usa **Gemma 3 1B** on-device (texto). Sin modelo instalado la UI muestra error (no Stub). Instala `gemma3-1b-it-int4.task` con `tools/push_model.ps1` (ver [Gemma setup](docs/GEMMA_SETUP.md)).

## Qué incluye el MVP

| Prioridad | Entrega |
|-----------|---------|
| P0 | Texto → lección + pizarra Canvas + TTS + LessonScript DSL + Gemma 1B |
| P1 | Micrófono STT sincronizado con el flujo de lección |
| P2 | PDF / multimodal — fuera de alcance con 1B |

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
