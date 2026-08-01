# Instalación del modelo Gemma 3n E2B — MVP demo

Objetivo: que **flutter_gemma** use el `.litertlm` en el teléfono para la demo.

## Por qué no “Descargas”

En Android 13+ la app **no puede leer** archivos empujados por `adb` a Download/Android/data (dueño `shell` → Permission denied). Por eso el modelo debe vivir en **Documents de la app** (`app_flutter`).

## Pasos (una vez por instalación de APK)

1. Instala la app (debug):

```powershell
cd app
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

**No uses** `flutter install` (desinstala y borra `app_flutter`).

2. Empuja el modelo **dentro** de la app:

```powershell
.\tools\push_model.ps1 -DeviceId <SERIAL> -ModelPath "C:\Users\jeanp\.litert-lm\models\gemma-3n-E2B-it\model.litertlm"
```

Eso hace: push → `/data/local/tmp` → `run-as pe.khipu.khipu_ai cp … app_flutter/gemma-3n-E2B-it-int4.litertlm`.

3. Abre Khipu. Chip **Gemma** / “Gemma listo”. Primera pregunta puede tardar **1–2 min** (carga del motor en RAM).

4. Smoke: `¿Cómo resuelvo 2x + 3 = 11?` → Motor: Gemma E2B (no Stub/fixtures).

## Código

```dart
await FlutterGemma.installModel(
  modelType: ModelType.gemmaIt,
  fileType: ModelFileType.litertlm,
).fromFile(documentsPath).install();
```

## Fallback

Si falla la carga (OOM, etc.), la UI muestra la razón y usa fixtures solo como degradación visible.
