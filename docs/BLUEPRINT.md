# Khipu AI — Blueprint MVP

## Visión (one-pager)

**Khipu AI** es un profesor personal offline en Android: no un chatbot. El estudiante pregunta (texto/voz) y ve a la IA enseñar en una pizarra digital paso a paso, hablando y dibujando al mismo tiempo.

- Offline-first, sin servidores de inferencia.
- Gratis, orientado a zonas rurales y baja alfabetización.
- Diferenciador: **LessonScript** → pizarra propia sincronizada con narración.

## Prioridad (corte MVP)

| Prioridad | Entrega | Estado blueprint |
|-----------|---------|------------------|
| **P0** | Texto → lección + pizarra animada (mates) + TTS + stub/Gemma | Must ship |
| **P1** | STT + sincronía voz↔pizarra | Tras P0 estable en ~4 GB |
| **P2** | Foto cuaderno / PDF | Stretch — cortar primero |

## Fases de implementación

1. **F0 Research** — Runtime Gemma para 4 GB (decisión: Gemma 3 1B int4 + `flutter_gemma`/MediaPipe; fallback stub).
2. **F1 Domain** — LessonScript DSL v0.1 + parser + validator + board reducer (TDD).
3. **F2 Whiteboard UI** — Canvas Flutter + player timeline.
4. **F3 Lesson flow** — Clean Architecture + Riverpod + stub teacher.
5. **F4 On-device AI** — Adapter Gemma detrás de puerto; fixtures si no hay modelo.
6. **F5 Voice P1** — TTS sync (P0) + STT (P1).
7. **F6 Verify** — Tests + DEMO.md + métricas documentadas.

## DoR / DoD

**Definition of Ready:** historia con criterio de aceptación, prioridad P0–P2, sin dependencia cloud.

**Definition of Done:** tests del dominio verdes, demo reproducible, sin crash en JSON inválido, AI intercambiable stub↔Gemma, docs actualizados.

## Historias P0 (resumen)

1. Como estudiante, escribo una pregunta de mates y veo pasos en la pizarra.
2. Como estudiante, escucho la explicación mientras se dibuja.
3. Como sistema, valido/reparo LessonScript antes de reproducir.
4. Como desarrollador, cambio stub por Gemma sin tocar UI.

## Demo 3 min (ver DEMO.md)

Pregunta: «¿Cómo resuelvo 2x + 3 = 11?» → socrático → pasos animados ≥5 → respuesta final.
