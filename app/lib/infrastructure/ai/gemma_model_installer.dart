import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import 'gemma_model_config.dart';

/// Instala gemma-3n-E2B-it-litert-lm desde archivo local o red (una vez).
class GemmaModelInstaller {
  const GemmaModelInstaller();

  bool get hasActiveModel => FlutterGemma.hasActiveModel();

  /// Instala desde ruta absoluta en el dispositivo (recomendado offline).
  Future<void> installFromFile(
    String absolutePath, {
    void Function(int progress)? onProgress,
  }) async {
    final builder = FlutterGemma.installModel(modelType: ModelType.gemmaIt)
        .fromFile(absolutePath);
    if (onProgress != null) {
      await builder.withProgress(onProgress).install();
    } else {
      await builder.install();
    }
    debugPrint('Khipu: modelo instalado desde archivo ($absolutePath)');
  }

  /// Descarga opcional por Wi‑Fi (requiere token HF si el repo es gated).
  Future<void> installFromNetwork({
    String? hfToken,
    void Function(int progress)? onProgress,
  }) async {
    final token = hfToken ??
        const String.fromEnvironment('HUGGINGFACE_TOKEN', defaultValue: '');
    final builder = FlutterGemma.installModel(modelType: ModelType.gemmaIt)
        .fromNetwork(
      GemmaModelConfig.networkUrl,
      token: token.isEmpty ? null : token,
    );
    if (onProgress != null) {
      await builder.withProgress(onProgress).install();
    } else {
      await builder.install();
    }
    debugPrint('Khipu: modelo instalado desde red');
  }
}
