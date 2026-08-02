# Instalación del modelo Gemma 4 E2B — MVP demo

Objetivo: que **flutter_gemma** + **LiteRT-LM** usen `gemma-4-E2B-it.litertlm` en el teléfono. La demo es **solo Gemma** (texto; sin fotos en este MVP).

## Artefacto

| Campo | Valor |
|-------|--------|
| Repo | `litert-community/gemma-4-E2B-it-litert-lm` |
| Archivo | `gemma-4-E2B-it.litertlm` (~2.58 GB) |
| Engine | `LiteRtLmEngine` |
| ModelType | `ModelType.gemma4` |
| Ruta PC tipica | `C:\Users\jeanp\.litert-lm\models\gemma-4-E2B-it\gemma-4-E2B-it.litertlm` |

El modelo en HF está **gated** (aceptar licencia Gemma). Token solo por env / `--dart-define=HUGGINGFACE_TOKEN=...` (nunca en el repo).

Samsung A54: **GO condicional** (~5 GB RAM libres deseables). Si OOM o JSON inválido → error visible o lección guiada con `degradedReason`.

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
.\tools\push_model.ps1 -DeviceId RFCW50YXPZD -ModelPath "C:\Users\jeanp\.litert-lm\models\gemma-4-E2B-it\gemma-4-E2B-it.litertlm"
```

Si quedó un modelo viejo, bórralo primero:

```powershell
adb -s RFCW50YXPZD shell "run-as pe.khipu.khipu_ai rm -f app_flutter/gemma3-1b-it-int4.task app_flutter/gemma-3n-E2B-it-int4.litertlm"
```

## Uso

1. Chip **Gemma** / “Gemma listo”.
2. Smoke: `¿Cómo resuelvo 2x + 3 = 11?` → **Motor: Gemma 4 E2B**.
3. Sin botones de cámara/galería en este MVP (visión off).

## Fallo explícito

Sin modelo u OOM → error en UI. JSON inválido dos veces → lección guiada local con `degradedReason` visible (sin Stub silencioso).
