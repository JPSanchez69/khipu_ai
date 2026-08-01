# Khipu AI

Profesor inteligente **offline** en Android: Gemma 3n E2B on-device + pizarra pedagógica (LessonScript).

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

Por defecto usa **StubTeacher** (fixtures). Instala `gemma-3n-E2B-it-int4.litertlm` desde la UI y activa el chip **Gemma**.

### Chrome en Windows

Si el repositorio está dentro de una ruta con espacios, como
`Proyectos Desarrollo UNI`, el proceso de `flutter run -d chrome` puede quedar
bloqueado en:

```text
Launching lib\main.dart on Chrome in debug mode...
```

En ese caso, no ejecutes `flutter run -d chrome` directamente. Usa el lanzador
incluido, que crea una unidad virtual temporal sin espacios.

Desde la raíz del repositorio:

```powershell
.\run_web.cmd
```

Desde la carpeta `app`:

```powershell
..\run_web.cmd
```

El lanzador ejecuta `flutter pub get`, inicia la aplicación en Chrome y elimina
la unidad temporal al terminar. La primera compilación puede tardar alrededor
de un minuto. Para detener Flutter, presiona `Ctrl+C`; si Windows pregunta
`¿Desea terminar el trabajo por lotes (S/N)?`, responde `N` para permitir que
el lanzador complete la limpieza.

La demo web inicia con **StubTeacher**. El modelo Gemma LiteRT-LM completo está
orientado a Android.

## Qué incluye el MVP

| Prioridad | Entrega |
|-----------|---------|
| P0 | Texto → lección + pizarra Canvas + TTS + LessonScript DSL + stub/Gemma port |
| P1 | Micrófono STT (JARVIS-lite) sincronizado con el flujo de lección |
| P2 | Foto cámara/galería (multimodal E2B); PDF no implementado |

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
