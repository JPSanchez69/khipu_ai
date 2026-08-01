import 'package:flutter_gemma/flutter_gemma.dart';

/// Constantes del modelo on-device (no empaquetado en el APK).
class GemmaModelConfig {
  GemmaModelConfig._();

  /// Artefacto Hugging Face (LiteRT-LM).
  static const repoId = 'google/gemma-3n-E2B-it-litert-lm';
  static const fileName = 'gemma-3n-E2B-it-int4.litertlm';

  /// LiteRT-LM exige este fileType (el default del plugin es `.task`).
  static const fileType = ModelFileType.litertlm;

  static const networkUrl =
      'https://huggingface.co/google/gemma-3n-E2B-it-litert-lm/resolve/main/gemma-3n-E2B-it-int4.litertlm';

  /// Contexto: texto 2048; con imagen 4096 (visión consume tokens).
  static const maxTokens = 2048;
  static const maxTokensWithImage = 4096;

  static const maxOutputTokens = 768;

  static const maxImageSide = 640;
  static const jpegQuality = 75;
  static const maxNumImages = 1;
}
