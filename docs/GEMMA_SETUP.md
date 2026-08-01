# Instalación del modelo Gemma (opcional)

El MVP funciona **sin modelo** (chip **Stub**): lecciones fixture + pizarra + TTS/STT.

Para on-device real (chip **Gemma**):

1. Dispositivo Android **minSdk 26**, idealmente **6–8 GB RAM**. En **4 GB** usar solo **Gemma 3 1B int4** (~0.5–0.8 GB).
2. Instalar el modelo una vez (Wi‑Fi), luego modo avión.
3. Runtime: `flutter_gemma` + `flutter_gemma_mediapipe` (`.task` / `.bin`).
4. Si `FlutterGemma.getActiveModel` falla, la app **cae a fixtures** automáticamente.

Ejemplo de instalación (código / docs flutter_gemma):

```dart
await FlutterGemma.installModel(modelType: ModelType.gemmaIt)
  .fromNetwork('<url-del-modelo-1b-int4>')
  .install();
```

**No** empaquetar E2B/E4B en el APK de demo 4 GB (OOM).
