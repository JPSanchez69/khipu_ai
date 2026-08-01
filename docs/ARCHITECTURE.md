# Khipu AI — Architecture

## Decisiones clave

### Runtime on-device (4–8 GB RAM)

| Opción | Ventajas | Desventajas | Decisión actual |
|--------|----------|-------------|-----------------|
| **Gemma 3n E2B int4 LiteRT-LM** (`gemma-3n-E2B-it-litert-lm`) | Multimodal (texto+imagen), mejor calidad pedagógica | ~3 GB disco; OOM frecuente en 4 GB | **Elegida** (instalación local, no en APK) |
| Gemma 3 1B int4 MediaPipe `.task` | Cabe en 4 GB | Sin visión útil | Fallback histórico / floor extremo |
| llama.cpp / GGUF | Control fino cuantización | FFI más pesado en Flutter | Alternativa si LiteRT falla |
| Cloud FastAPI | Fácil | Rompe offline | **Fuera de producto** |

**Kill criteria:** OOM o fallo de carga E2B → **Stub + fixtures** sin crash. Imágenes siempre redimensionadas (lado máx. 640). No empaquetar pesos en el APK.

**Runtime:** `flutter_gemma` + `flutter_gemma_litertlm` (`LiteRtLmEngine`). Backend: GPU con fallback CPU.

### App architecture

```
presentation (Flutter UI + Riverpod)
    ↓
application (AskQuestion, PlayLesson)
    ↓
domain (LessonScript, BoardState, TeacherPort, PhotoPicker)
    ↓
infrastructure (StubTeacher, GemmaTeacher, ImagePrep, Tts, Stt, fixtures)
```

- **Clean Architecture** + **feature-first** bajo `lib/features/` y núcleo en `lib/core/`.
- **Offline-first:** sin red para inferir; modelo instalable una vez (archivo o Wi‑Fi).
- **Puerto `TeacherAiPort`:** stub ↔ Gemma; `TeachRequest` admite JPEG opcional.

### LessonScript DSL v0.1

JSON versionado (`schemaVersion: "0.1"`). Acciones:

`writeText`, `drawShape`, `drawArrow`, `highlight`, `move`, `erase`,
`timeline`, `conceptNode`, `wait`, `speakCue`, `askSocratic`.

Flutter interpreta y anima; el modelo emite JSON (reparación tolerante).

### Multimodal

- Entrada: texto, STT y/o **una foto** (cámara/galería).
- Pipeline: `ImagePrep` → JPEG ≤640px → `Message.withImage` si hay modelo.
- Sin PDF en este slice.

### TTS

- `flutter_tts` del sistema: voz ES preferida (`es-MX`/`es-ES`), rate/pitch suaves, **chunking** por oraciones (`TtsChunker`), `awaitSpeakCompletion`.
- Sin TTS neuronal (presupuesto RAM compartido con E2B).

### Memoria y rendimiento

- Contexto corto (`maxTokens` 1024).
- Una imagen por turno; cerrar chat tras inferir.
- Canvas: elementos inmutables + `CustomPainter`.
- Android `largeHeap=true`; OpenCL opcional.

### minSdk

Android **minSdk 26**; LiteRT-LM FFI es **arm64-v8a**.

### Seguridad / menores

- Sin telemetría PII.
- Sin cuentas ni cloud de inferencia.
- Cámara/galería detrás de `PhotoPickerPort`.

### Limitaciones honestas

- Demo siempre posible con **StubTeacher**.
- E2B en 4 GB es best-effort; fixtures garantizan la experiencia.
- Calidad TTS limitada al motor del sistema del dispositivo.
