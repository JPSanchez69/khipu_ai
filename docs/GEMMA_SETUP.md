# Instalación del modelo Gemma 3n E2B (opcional)

El MVP funciona **sin modelo** (chip **Stub**): lecciones fixture + pizarra + TTS/STT.

Modelo objetivo: **`gemma-3n-E2B-it-litert-lm`** → archivo  
`gemma-3n-E2B-it-int4.litertlm` (multimodal texto+imagen).

**No** se empaqueta en el APK (~3 GB). Instalación local o descarga una vez.

## Requisitos

1. Android **minSdk 26**, **arm64-v8a**. Ideal **≥6 GB RAM**. En **4 GB** es frecuente OOM → la app cae a fixtures sin crash.
2. Runtime: `flutter_gemma` + **`flutter_gemma_litertlm`** (`.litertlm` / LiteRT-LM).
3. Repo gated en Hugging Face: pide acceso a  
   [google/gemma-3n-E2B-it-litert-lm](https://huggingface.co/google/gemma-3n-E2B-it-litert-lm).

## Opción A — Archivo en el teléfono (recomendado)

1. Copia `gemma-3n-E2B-it-int4.litertlm` al teléfono (PC → adb o descarga).
   Preferido (scoped storage, legible por la app):

   ```bash
   adb push gemma-3n-E2B-it-int4.litertlm /sdcard/Android/data/pe.khipu.khipu_ai/files/
   ```

   Alternativa: `/sdcard/Download/` (puede fallar por permisos en Android 11+).
2. En la app: icono de modelo → **Instalar desde Descargas**.
3. Activa el chip **Gemma**. Luego puedes usar modo avión.

Equivalente en código:

```dart
await FlutterGemma.installModel(modelType: ModelType.gemmaIt)
  .fromFile('/ruta/absoluta/gemma-3n-E2B-it-int4.litertlm')
  .install();
```

## Opción B — Descarga Wi‑Fi (una vez)

Token HF (repo gated):

```bash
flutter run --dart-define=HUGGINGFACE_TOKEN=hf_xxx
```

En la app: **Descargar una vez (Wi‑Fi)**, o:

```dart
await FlutterGemma.installModel(modelType: ModelType.gemmaIt)
  .fromNetwork(
    'https://huggingface.co/google/gemma-3n-E2B-it-litert-lm/resolve/main/gemma-3n-E2B-it-int4.litertlm',
    token: 'hf_xxx',
  )
  .withProgress((p) => print('$p%'))
  .install();
```

## Multimodal (foto)

- Cámara o galería → resize lado máx. **640 px**, JPEG ~75%.
- Una imagen por pregunta. Texto y/o STT siguen disponibles.
- Si no hay modelo / OOM → fixtures.

## Fallback

Si `FlutterGemma.hasActiveModel()` es false o `getActiveModel` / inferencia fallan, **Stub/fixtures** automáticamente. El chip puede decir **Gemma…** (no listo).

## Gama baja / media-baja

| Presupuesto | Comportamiento |
|-------------|----------------|
| Disco | ~3 GB para el `.litertlm` (fuera del APK) |
| RAM pico | ~2.4–3 GB+ con visión; `largeHeap`; GPU→CPU |
| Contexto | `maxTokens` 1024, `maxOutputTokens` 768 |
| Kill | OOM → fixtures; no crashear la demo Stub |
