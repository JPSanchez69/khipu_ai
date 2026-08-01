/// Constantes del modelo on-device (no empaquetado en el APK).
class GemmaModelConfig {
  GemmaModelConfig._();

  /// Artefacto Hugging Face (LiteRT-LM).
  static const repoId = 'google/gemma-3n-E2B-it-litert-lm';
  static const fileName = 'gemma-3n-E2B-it-int4.litertlm';

  static const networkUrl =
      'https://huggingface.co/google/gemma-3n-E2B-it-litert-lm/resolve/main/gemma-3n-E2B-it-int4.litertlm';

  /// URL que `run_web.cmd` expone desde la carpeta local `models/`.
  /// Chrome no puede abrir una ruta C:\\ directamente, por eso se usa HTTP local.
  static const localWebUrl = String.fromEnvironment(
    'GEMMA_MODEL_URL',
    defaultValue: 'http://127.0.0.1:8765/gemma-3n-E2B-it-int4.litertlm',
  );

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
