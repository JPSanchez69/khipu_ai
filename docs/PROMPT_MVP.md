# Khipu AI — Prompt MVP (listo para pegar)

Use the blueprint skill to plan and then drive implementation of MVP only for **Khipu AI** — greenfield Android Flutter app: on-device Gemma teacher with synchronized intelligent whiteboard. NOT a chatbot. Offline-first. Free. Spanish UI and explanations.

# Context (fixed)
- Greenfield repo (no existing code/conventions).
- Team strengths: Flutter/Dart, Python, Gemma familiarity. Learn new tech only if it unblocks on-device inference.
- Target devices: Android mid/low — **floor 4 GB RAM**, optimize for devices up to 8 GB. Prefer Android 10+ if toolchain allows; document minSdk chosen.
- Product metaphor: ChatGPT Voice × Khanmigo × JARVIS × classroom blackboard — teach by drawing step-by-step, not dumping answers.
- Pedagogy: guided learning, Socratic questions, step-by-step, analogies, similar exercises. Never dump the full solution at once.
- Social goal: rural students with limited/no internet and high illiteracy risk — UI must be ultra-simple, large tap targets, voice-friendly, low reading load.

# Critical product decision (resolve the “everything” tension)
User wants multimodal eventually (text, voice, photo notebook, PDF). For MVP you MUST ruthlessly prioritize. Do NOT pretend all are equal.

## P0 — Demo star (must ship)
1. Text question → spoken + written lesson.
2. Custom whiteboard that plays a structured **LessonScript** (JSON) in sync with narration/text.
3. Math vertical: solve a simple equation / arithmetic / algebra-1 style problem with animated steps (write, highlight, arrows, move terms, pause between steps).
4. Fully offline inference path for the lesson (even if model is bundled/downloaded once before airplane mode demo).

## P1 — Only after P0 is stable on a 4 GB device
5. Voice input (STT on-device) + TTS output synchronized with whiteboard timeline (JARVIS-lite).
6. Camera: photo of notebook → OCR/vision pipeline on-device OR pragmatic hybrid for hackathon IF pure on-device vision is infeasible on 4 GB — but document honesty: prefer on-device; if forced to mock/stub vision for demo, isolate behind interface.

## P2 — Stretch / cut first under time pressure
7. PDF → concept map / diagram LessonScript.
8. Rich history domain animations (dinosaurs/Earth) beyond basic shapes/timeline primitives.

Kill criteria: if RAM > ~2.5–3 GB peak for model+app on 4 GB phone, or first token / first board action > UX budget you set, shrink model size / quant / context / modality — never add features.

# Out of scope for this MVP (do NOT build)
- FastAPI, Vercel, GCP, cloud inference, accounts, payments, social, LMS, teacher dashboard.
- Excalidraw embed or any web whiteboard dependency.
- Image generation (Stable Diffusion etc.). Explanations are vector/canvas constructed step-by-step.
- Replacing teachers / full curriculum coverage / multi-grade content packs.
- iOS (Android-first).
- Perfect Socratic tutor across all subjects.

# Architecture requirements
Act as CTO: challenge weak ideas; prefer robust alternatives with why / trade-offs / risks / scalability.

Deliver and implement:
1. Product: MVP vision one-pager, user flows for P0, acceptance criteria, demo script (3 minutes).
2. Architecture: Clean Architecture + feature-first Flutter modules; Offline-first; On-device AI boundary (ports/adapters); memory & performance strategy for 4 GB.
3. Folder structure, Riverpod, navigation, theming, reusable widgets.
4. Whiteboard: own Flutter Canvas engine + **LessonScript JSON DSL v0.1** with actions: writeText, drawShape (circle/rect/line), drawArrow, highlight, move, erase, timeline, conceptNode, wait/pause, speakCue. Versioned schema + validator. Flutter interprets and animates; model emits JSON (constrained / repaired).
5. AI: research-first to pick Gemma variant + Android runtime among LiteRT / MediaPipe LLM Inference / ONNX / GGUF(llama.cpp) — argue with RAM budget, quantization (prefer 4-bit class), context window, multimodal readiness, Flutter integration path. Document chosen stack in ARCHITECTURE.md.
6. Prompting: system prompts for teacher persona + JSON-only LessonScript emitter; streaming tokens → progressive board render; context management for low RAM.
7. UX: child/teen-friendly, modern, minimal, playful but not childish clutter.
8. Performance: token streaming, progressive canvas, animation budget, model size target.
9. Delivery: epics/features/user stories for P0–P2 only; DoR/DoD.

# Workflow (mandatory)
1. Blueprint MVP phases (each phase = reviewable slice).
2. Phase 0 research: on-device Gemma options for 4 GB — decide runtime+model+quant.
3. /plan architecture + LessonScript schema + module boundaries before coding.
4. /tdd for domain: LessonScript parse/validate/replay timing; pure Dart tests first.
5. Implement P0 vertical slice end-to-end (stub LLM fixtures, then swap real Gemma).
6. Integrate real on-device model; measure RAM/latency; tune.
7. Only then P1 voice; then photo if budget remains.
8. /code-review after each phase; /verify with checklist.
9. /save-session between phases if context grows.

# Acceptance criteria (MVP done when)
- [ ] Airplane-mode demo: ask a math question in Spanish → app speaks/shows text AND whiteboard animates ≥5 sequenced actions from LessonScript without crash on ~4 GB class device (or documented closest test device).
- [ ] LessonScript schema validated; invalid JSON safely repaired or user-friendly error (no crash).
- [ ] Pedagogy: solution revealed stepwise with pauses; at least one Socratic prompt before final answer in the happy path.
- [ ] Clean Architecture folders + AI behind an interface (swap stub ↔ Gemma).
- [ ] ARCHITECTURE.md + DEMO.md (script) + known limitations honest (what P1/P2 missing).
- [ ] Peak memory strategy documented; model quant/size chosen for 4–8 GB.
- [ ] No cloud required for inference after model present on device.
