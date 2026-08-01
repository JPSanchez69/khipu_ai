import 'package:flutter_gemma/flutter_gemma.dart';

/// Constantes del modelo on-device (no empaquetado en el APK).
class GemmaModelConfig {
  GemmaModelConfig._();

  /// Artefacto Hugging Face (MediaPipe .task).
  static const repoId = 'litert-community/Gemma3-1B-IT';
  static const fileName = 'gemma3-1b-it-int4.task';

  /// MediaPipe LLM Inference usa .task (no LiteRT-LM).
  static const fileType = ModelFileType.task;

  static const networkUrl =
      'https://huggingface.co/litert-community/Gemma3-1B-IT/resolve/main/gemma3-1b-it-int4.task';

  /// Contexto texto (1B no multimodal).
  static const maxTokens = 2048;

  /// Salida corta: fuerza JSON LessonScript compacto en 1B.
  static const maxOutputTokens = 384;

  /// Prep de fotos (galeria/camara); el picker sigue redimensionando.
  static const maxImageSide = 640;
  static const jpegQuality = 75;
}