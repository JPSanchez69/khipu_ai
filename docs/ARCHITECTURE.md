# Khipu AI — Architecture

## Decisiones clave

### Runtime on-device (4–8 GB RAM)

| Opción | Ventajas | Desventajas | Decisión MVP |
|--------|----------|-------------|-------------|
| **Gemma 3 1B int4 + flutter_gemma (MediaPipe `.task`)** | ~0.5–0.8 GB disco, ~0.8–1.4 GB RAM pico; API Flutter; offline | Calidad menor que E2B/E4B; vision limitada | **Elegida para floor 4 GB** |
| Gemma 3n / Gemma 4 E2B | Multimodal, mejor calidad | 2.4–3 GB+; OOM frecuente en 4 GB | Solo en dispositivos ≥6 GB (futuro flag) |
| llama.cpp / GGUF | Control fino cuantización | Integración Flutter más pesada (FFI) | Alternativa si MediaPipe falla |
| ONNX Runtime GenAI | Portable | Ecosistema Gemma móvil menos maduro en Flutter | No MVP |
| Cloud FastAPI | Fácil | Rompe promesa offline | **Fuera de MVP** |

**Kill criteria:** pico modelo+app > ~2.5–3 GB en teléfono 4 GB → bajar a stub + lecciones fixture, o modelo 270M, nunca añadir modalidades.

### App architecture

```
presentation (Flutter UI + Riverpod)
    ↓
application (use cases: AskQuestion, PlayLesson)
    ↓
domain (LessonScript, BoardState, TeacherPort)
    ↓
infrastructure (StubTeacher, GemmaTeacher, Tts, Stt, fixtures)
```

- **Clean Architecture** + **feature-first** bajo `lib/features/` y núcleo en `lib/core/`.
- **Offline-first:** sin red para inferir; el modelo puede descargarse una vez (documentado).
- **Puerto `TeacherAiPort`:** stub ↔ Gemma sin tocar UI.

### LessonScript DSL v0.1

JSON versionado (`schemaVersion: "0.1"`). Acciones:

`writeText`, `drawShape`, `drawArrow`, `highlight`, `move`, `erase`, `timeline`, `conceptNode`, `wait`, `speakCue`, `askSocratic`.

Flutter interpreta y anima; el modelo emite JSON (con reparación tolerante).

### Memoria y rendimiento

- Contexto corto (preguntas + system prompt compacto).
- Streaming de tokens → parseo incremental cuando sea posible; MVP: JSON completo luego play.
- Canvas: lista de elementos inmutables + `CustomPainter`; animaciones 200–600 ms.
- TTS no bloquea el player (cues por `speakCue` / `wait`).

### minSdk

Android **minSdk 26** (requisito típico MediaPipe GenAI / flutter_gemma). Documentado; targetSdk actual Flutter.

### Seguridad / menores

- Sin telemetría PII en MVP.
- Sin cuentas ni cloud.
- Cámara/galería solo detrás de puerto (P1/P2); foto no en P0.

### Limitaciones honestas

- P0 puede demostar con **StubTeacher** si el modelo no está en el dispositivo.
- Foto/PDF = P2 no implementado en código de producto (puertos preparados).
- Calidad pedagógica del modelo 1B es limitada; fixtures garantizan la demo.
