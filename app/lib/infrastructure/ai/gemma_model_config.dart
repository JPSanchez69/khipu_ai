/// Constantes del modelo on-device (no empaquetado en el APK).
class GemmaModelConfig {
  GemmaModelConfig._();

  /// Artefacto Hugging Face (LiteRT-LM).
  static const repoId = 'google/gemma-3n-E2B-it-litert-lm';
  static const fileName = 'gemma-3n-E2B-it-int4.litertlm';

  static const networkUrl =
      'https://huggingface.co/google/gemma-3n-E2B-it-litert-lm/resolve/main/gemma-3n-E2B-it-int4.litertlm';

  /// Rutas típicas tras adb push / copia del usuario.
  /// Preferir `Android/data/pe.khipu.khipu_ai/files/` (scoped storage).
  static const androidDownloadCandidates = <String>[
    '/storage/emulated/0/Android/data/pe.khipu.khipu_ai/files/gemma-3n-E2B-it-int4.litertlm',
    '/sdcard/Android/data/pe.khipu.khipu_ai/files/gemma-3n-E2B-it-int4.litertlm',
    '/sdcard/Download/gemma-3n-E2B-it-int4.litertlm',
    '/storage/emulated/0/Download/gemma-3n-E2B-it-int4.litertlm',
  ];

  /// Contexto corto para gama baja/media-baja (.litertlm mínimo ~1024).
  static const maxTokens = 1024;

  static const maxOutputTokens = 768;

  static const maxImageSide = 640;
  static const jpegQuality = 75;
  static const maxNumImages = 1;
}
