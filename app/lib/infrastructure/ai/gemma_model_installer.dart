import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import 'gemma_model_config.dart';

/// Instala gemma-3n-E2B-it-litert-lm desde archivo local o red (una vez).
class GemmaModelInstaller {
  const GemmaModelInstaller();

  bool get hasActiveModel => FlutterGemma.hasActiveModel();

  /// Busca el .litertlm en Descargas del teléfono (flujo Android típico).
  Future<String?> findLocalModelPath() async {
    if (kIsWeb) return null;
    for (final path in GemmaModelConfig.androidDownloadCandidates) {
      final f = File(path);
      if (await f.exists()) return path;
    }
    return null;
  }

  /// Instala desde Descargas si el archivo ya está en el dispositivo.
  Future<void> installFromDownloads({
    void Function(int progress)? onProgress,
  }) async {
    final path = await findLocalModelPath();
    if (path == null) {
      throw StateError(
        'No se encontró ${GemmaModelConfig.fileName} en Descargas',
      );
    }
    await installFromFile(path, onProgress: onProgress);
  }

  /// Instala desde ruta absoluta en el dispositivo (recomendado offline).
  Future<void> installFromFile(
    String absolutePath, {
    void Function(int progress)? onProgress,
  }) async {
    final builder = FlutterGemma.installModel(
      modelType: ModelType.gemmaIt,
      fileType: ModelFileType.litertlm,
    ).fromFile(absolutePath);
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
    String? url,
    void Function(int progress)? onProgress,
  }) async {
    final token =
        hfToken ??
        (url == null
            ? const String.fromEnvironment(
                'HUGGINGFACE_TOKEN',
                defaultValue: '',
              )
            : '');
    final builder =
        FlutterGemma.installModel(
          modelType: ModelType.gemmaIt,
          fileType: ModelFileType.litertlm,
        ).fromNetwork(
          url ?? GemmaModelConfig.networkUrl,
          token: token.isEmpty ? null : token,
        );
    if (onProgress != null) {
      await builder.withProgress(onProgress).install();
    } else {
      await builder.install();
    }
    debugPrint('Khipu: modelo instalado desde red');
  }

  /// Copia el modelo servido por `run_web.cmd` al almacenamiento persistente
  /// (OPFS) del navegador. Solo se necesita la primera vez por perfil de Chrome.
  Future<void> installLocalWeb({void Function(int progress)? onProgress}) {
    if (!kIsWeb) {
      throw UnsupportedError(
        'La instalación web local solo funciona en Chrome',
      );
    }
    return installFromNetwork(
      url: GemmaModelConfig.localWebUrl,
      onProgress: onProgress,
    );
  }
}
