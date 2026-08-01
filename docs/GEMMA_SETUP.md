# Instalación del modelo Gemma 3 1B-IT — MVP demo

Objetivo: que **flutter_gemma** + **MediaPipe** usen `gemma3-1b-it-int4.task` en el teléfono. La demo es **solo Gemma** (texto; sin fotos).

## Artefacto

| Campo | Valor |
|-------|--------|
| Repo | `litert-community/Gemma3-1B-IT` |
| Archivo | `gemma3-1b-it-int4.task` (~555 MB) |
| Engine | `MediaPipeEngine` |
| Ruta PC tipica | `C:\Users\jeanp\.litert-lm\models\gemma-3-1b-it\gemma3-1b-it-int4.task` |

El modelo en HF está **gated** (aceptar licencia Gemma). También se puede usar un mirror del mismo archivo si ya lo tienes en disco.

## Por qué no “Descargas”

En Android 13+ la app **no puede leer** archivos empujados por `adb` a Download/Android/data. El modelo debe vivir en **Documents de la app** (`app_flutter`).

## Pasos

### Opción A — desarrollo

```powershell
cd app
flutter run -d RFCW50YXPZD --debug
```

### Opción B — APK sin borrar datos

```powershell
cd app
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

**No uses** `flutter install` (borra `app_flutter`).

### Empujar el modelo

```powershell
.\tools\push_model.ps1 -DeviceId RFCW50YXPZD -ModelPath "C:\Users\jeanp\.litert-lm\models\gemma-3-1b-it\gemma3-1b-it-int4.task"
```

Si quedó el E2B viejo, bórralo primero:

```powershell
adb -s RFCW50YXPZD shell "run-as pe.khipu.khipu_ai rm -f app_flutter/gemma-3n-E2B-it-int4.litertlm"
```

## Uso

1. Chip **Gemma** / “Gemma listo”.
2. Smoke: `¿Cómo resuelvo 2x + 3 = 11?` → **Motor: Gemma 3 1B**.
3. Sin botones de cámara/galería (1B no es multimodal).

## Fallo explícito

Sin modelo, OOM o JSON inválido → error en UI; pizarra vacía (sin fixtures).
