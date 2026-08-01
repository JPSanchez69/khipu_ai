# Khipu AI — Demo script (3 minutos)

## Preparación

1. Abrir la app en Android (dispositivo o emulador).
2. Modo avión ON (tras tener el modelo en disco, si usas Gemma; con StubTeacher no hace falta modelo).
3. En Ajustes/estado: confirmar motor **Stub** o **Gemma**.

## Guion

| Tiempo | Acción | Qué mostrar |
|--------|--------|-------------|
| 0:00 | Home: «Pregúntale a Khipu» | UI simple, pizarra vacía |
| 0:20 | Escribir: `¿Cómo resuelvo 2x + 3 = 11?` | Teclado / chip de ejemplo |
| 0:30 | Enviar | Loading breve |
| 0:40 | Pregunta socrática en voz/texto | «¿Qué pasa si resto 3 a ambos lados?» |
| 0:55 | Pizarra: escribe ecuación | `writeText` |
| 1:10 | Resalta `+ 3`, flecha, mueve términos | ≥5 acciones |
| 1:40 | Pausas entre pasos | Sensación de profesor |
| 2:10 | Llega a `x = 4` | Highlight final |
| 2:30 | (P1) Micrófono: misma pregunta por voz | STT → misma lección |
| 2:50 | Cerrar: «Sin internet, en el bolsillo» | Airplane mode visible |

## Checklist verificación

- [ ] ≥5 acciones de pizarra secuenciadas
- [ ] No crash con JSON inválido (probar pregunta basura → error amigable o fixture fallback)
- [ ] TTS habla al menos un `speakCue`
- [ ] Stub ↔ Gemma intercambiables en código (`TeacherAiPort`)
