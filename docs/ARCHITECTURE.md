# Khipu AI — Architecture

## Decisiones clave

### Runtime on-device (4–8 GB RAM)

| Opción | Ventajas | Desventajas | Decisión actual |
|--------|----------|-------------|-----------------|
| **Gemma 4 E2B LiteRT-LM `.litertlm`** (`litert-community/gemma-4-E2B-it-litert-lm`) | Mejor calidad JSON; ~2.58 GB | Más RAM/latencia que 1B; OOM posible en A54 | **Elegida (GO condicional)** |
| Gemma 3 1B-IT int4 MediaPipe `.task` | Cabe en 4–8 GB; ~555 MB | Sin visión; JSON más frágil | Histórico / rollback |
| Gemma 3n E2B int4 LiteRT-LM | Multimodal | ~3.6 GB; OOM frecuente | Histórico |
| Cloud FastAPI | Fácil | Rompe offline | **Fuera de producto** |

**Kill criteria:** OOM, modelo ausente o JSON inválido → **error visible en UI** o lección guiada con `degradedReason`. No empaquetar pesos en el APK.

**Runtime:** `flutter_gemma` + `flutter_gemma_litertlm` (`LiteRtLmEngine`, `ModelType.gemma4`).  
**Install:** `ModelFileType.litertlm` + `FileSource` desde app-files (`ensureModelInstalled`).  
**Backend:** CPU primero, GPU respaldo (A54).

### App architecture

```
presentation (Flutter UI + Riverpod)
    ↓
application (AskQuestion, PlayLesson)
    ↓
domain (LessonScript, BoardState, TeacherPort)
    ↓
infrastructure (GemmaTeacher, StubTeacher tests, Tts, Stt)
```

- **Clean Architecture** + **feature-first** bajo `lib/features/` y núcleo en `lib/core/`.
- **Offline-first:** sin red para inferir; modelo en app-files o Wi‑Fi opcional (descarga).
- **Puerto `TeacherAiPort`:** éxito solo con `engine: gemma`; fallos → `TeacherAiException`.

### LessonScript DSL v0.1

JSON versionado (`schemaVersion: "0.1"`). Acciones:

`writeText`, `drawShape`, `drawArrow`, `highlight`, `move`, `erase`,
`timeline`, `conceptNode`, `wait`, `speakCue`, `askSocratic`.

Flutter interpreta y anima; el modelo emite JSON (reparación tolerante).

### Entrada (texto only)

- Texto y/o STT.
- **Sin foto/cámara** en producto (1B no multimodal). Si llega imagen al teacher → excepción.

### TTS

- `flutter_tts` del sistema: voz ES preferida (`es-MX`/`es-ES`), rate/pitch suaves, **chunking** por oraciones (`TtsChunker`), `awaitSpeakCompletion`.
- Sin TTS neuronal (presupuesto RAM compartido con el LLM).

### Memoria y rendimiento

- Contexto: `maxTokens` 2048.
- Cerrar chat tras inferir.
- Canvas: elementos inmutables + `CustomPainter`.
- Android `largeHeap=true`.

### minSdk

Android **minSdk 26**; ABI **arm64-v8a**.

### Seguridad / menores

- Sin telemetría PII.
- Sin cuentas ni cloud de inferencia.

### Limitaciones honestas

- 1B puede devolver JSON incompleto → error visible; el estudiante reintenta.
- Calidad TTS limitada al motor del sistema del dispositivo.
- StubTeacher solo en tests unitarios, no en demo de producto.
