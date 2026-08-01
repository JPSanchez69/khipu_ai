# Instalación del modelo Gemma 3n E2B — MVP demo

Objetivo: que **flutter_gemma** use el `.litertlm` en el teléfono. La demo es **solo Gemma** (sin Stub/fixtures).

## Por qué no “Descargas”

En Android 13+ la app **no puede leer** archivos empujados por `adb` a Download/Android/data (dueño `shell` → Permission denied). Por eso el modelo debe vivir en **Documents de la app** (`app_flutter`).

## Pasos (una vez por instalación de APK)

### Opción A — desarrollo

```powershell
cd app
flutter run -d RFCW50YXPZD --debug
```

Luego, si el modelo no está en `app_flutter`, empújalo (paso 2 abajo).

### Opción B — APK sin borrar datos

```powershell
cd app
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

**No uses** `flutter install` (desinstala y borra `app_flutter`).

### Empujar el modelo

```powershell
.\tools\push_model.ps1 -DeviceId RFCW50YXPZD -ModelPath "C:\Users\jeanp\.litert-lm\models\gemma-3n-E2B-it\model.litertlm"
```

Eso hace: push → `/data/local/tmp` → `run-as pe.khipu.khipu_ai cp … app_flutter/gemma-3n-E2B-it-int4.litertlm`.

## Uso

1. Abre Khipu. Chip **Gemma** / subtítulo “Gemma listo”.
2. Primera pregunta puede tardar **1–2 min** (carga del motor en RAM).
3. Smoke: `¿Cómo resuelvo 2x + 3 = 11?` → **Motor: Gemma E2B** y dibujo en pizarra.

## Fallo explícito (sin fixtures)

Si no hay modelo, OOM o el JSON de LessonScript es inválido:

- La UI muestra un error claro (“Gemma no está listo…” / memoria / lección inválida).
- La pizarra **no** se llena con respuestas de ejemplo.
- Reintenta tras `push_model.ps1`, cerrar apps (RAM) o otra pregunta.

## Código

```dart
await FlutterGemma.installModel(
  modelType: ModelType.gemmaIt,
  fileType: ModelFileType.litertlm,
).fromFile(documentsPath).install();
```
