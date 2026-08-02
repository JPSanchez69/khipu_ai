import 'package:flutter_gemma/flutter_gemma.dart';

/// Constantes del modelo on-device (no empaquetado en el APK).
class GemmaModelConfig {
  GemmaModelConfig._();

  /// Artefacto Hugging Face (LiteRT-LM .litertlm) — Gemma 4 E2B.
  static const repoId = 'litert-community/gemma-4-E2B-it-litert-lm';
  static const fileName = 'gemma-4-E2B-it.litertlm';

  /// Gemma 4 requiere LiteRT-LM (no MediaPipe .task).
  static const fileType = ModelFileType.litertlm;

  /// Chat template / tool-call path nativo de Gemma 4.
  static const modelType = ModelType.gemma4;

  static const networkUrl =
      'https://huggingface.co/litert-community/gemma-4-E2B-it-litert-lm/resolve/main/gemma-4-E2B-it.litertlm';

  /// Contexto KV-cache (.litertlm mínimo 1024; E2B aguanta más que 1B).
  static const maxTokens = 2048;

  /// Salida LessonScript (E2B puede JSON un poco más largo).
  static const maxOutputTokens = 512;

  /// Prep de fotos (galeria/camara); el picker sigue redimensionando.
  static const maxImageSide = 640;
  static const jpegQuality = 75;

  /// Etiqueta UI / engine hint.
  static const displayName = 'Gemma 4 E2B';
}
