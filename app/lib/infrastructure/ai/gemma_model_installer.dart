import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:path_provider/path_provider.dart';

import 'gemma_model_config.dart';
import 'gemma_status.dart';

/// Cache opcional del último bootstrap (tests / reintentos).
class GemmaBootstrapCache {
  static GemmaStatus? last;
}

/// MVP: registra el .litertlm desde Documents (app_flutter) para flutter_gemma.
///
/// El archivo debe estar en Documents de la app (propiedad de la app).
/// Usar: `.\tools\push_model.ps1` (run-as → app_flutter).
/// No copiar desde Download/Android/data (Permission denied en Android 13+).
class GemmaModelInstaller {
  GemmaModelInstaller({
    Future<String?> Function()? this._resolveModelPath,
    Future<void> Function(
      String absolutePath, {
      void Function(int progress)? onProgress,
    })? this._installImpl,
  });

  final Future<String?> Function()? _resolveModelPath;
  final Future<void> Function(
    String absolutePath, {
    void Function(int progress)? onProgress,
  })? _installImpl;

  var _installCallCount = 0;
  String? _sessionInstalledPath;

  @visibleForTesting
  int get installCallCount => _installCallCount;

  bool get hasActiveModel => FlutterGemma.hasActiveModel();

  /// Solo Documents / ruta inyectada (legible por la app).
  Future<String?> findLocalModelPath() async {
    final custom = _resolveModelPath;
    if (custom != null) return custom();

    try {
      final docs = await getApplicationDocumentsDirectory();
      final path = '${docs.path}/${GemmaModelConfig.fileName}';
      final f = File(path);
      if (await f.exists() && await f.length() > 0) return path;
    } catch (e) {
      debugPrint('Khipu: Documents no disponible: $e');
    }
    return null;
  }

  /// Registra el modelo en flutter_gemma (FileSource, fileType litertlm).
  Future<GemmaStatus> ensureModelInstalled({
    void Function(int progress)? onProgress,
  }) async {
    if (FlutterGemma.hasActiveModel() || _sessionInstalledPath != null) {
      // ignore: avoid_print
      print('Khipu: modelo ya activo para flutter_gemma');
      onProgress?.call(100);
      return const GemmaReady();
    }

    final path = await findLocalModelPath();
    // ignore: avoid_print
    print('Khipu: ensureModelInstalled path=$path');
    if (path == null) {
      return const GemmaNotInstalled();
    }

    try {
      onProgress?.call(10);
      await installFromFile(path);
      onProgress?.call(100);
      _sessionInstalledPath = path;
      if (!FlutterGemma.hasActiveModel() && _installImpl == null) {
        return const GemmaFailed('Registro falló (hasActiveModel=false)');
      }
      // ignore: avoid_print
      print('Khipu: flutter_gemma listo (fileType=litertlm)');
      return const GemmaReady();
    } catch (e) {
      // ignore: avoid_print
      print('Khipu: ensureModelInstalled falló: $e');
      return GemmaFailed('$e');
    }
  }

  Future<void> installFromFile(
    String absolutePath, {
    void Function(int progress)? onProgress,
  }) async {
    _installCallCount++;
    if (_installImpl != null) {
      await _installImpl(absolutePath, onProgress: onProgress);
      return;
    }

    await FlutterGemma.installModel(
      modelType: ModelType.gemmaIt,
      fileType: GemmaModelConfig.fileType,
    ).fromFile(absolutePath).install();
    onProgress?.call(100);
    debugPrint(
      'Khipu: registrado $absolutePath (${GemmaModelConfig.fileType.name})',
    );
  }

  Future<void> installFromNetwork({
    String? hfToken,
    void Function(int progress)? onProgress,
  }) async {
    final token = hfToken ??
        const String.fromEnvironment('HUGGINGFACE_TOKEN', defaultValue: '');
    final builder = FlutterGemma.installModel(
      modelType: ModelType.gemmaIt,
      fileType: GemmaModelConfig.fileType,
    ).fromNetwork(
      GemmaModelConfig.networkUrl,
      token: token.isEmpty ? null : token,
    );
    if (onProgress != null) {
      await builder.withProgress(onProgress).install();
    } else {
      await builder.install();
    }
  }
}
