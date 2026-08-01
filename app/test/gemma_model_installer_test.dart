import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_model_installer.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_status.dart';

void main() {
  group('ensureModelInstalled', () {
    test('notInstalled si no hay archivo', () async {
      final installer = GemmaModelInstaller(
        resolveModelPath: () async => null,
        installImpl: (path, {onProgress}) async {},
      );
      final status = await installer.ensureModelInstalled();
      expect(status, isA<GemmaNotInstalled>());
      expect(installer.installCallCount, 0);
    });

    test('ready e idempotente si el archivo existe', () async {
      final installer = GemmaModelInstaller(
        resolveModelPath: () async => '/fake/gemma.task',
        installImpl: (path, {onProgress}) async {
          onProgress?.call(100);
        },
      );
      final first = await installer.ensureModelInstalled();
      final second = await installer.ensureModelInstalled();
      expect(first, isA<GemmaReady>());
      expect(second, isA<GemmaReady>());
      expect(installer.installCallCount, 1);
    });

    test('failed si installImpl lanza', () async {
      final installer = GemmaModelInstaller(
        resolveModelPath: () async => '/fake/gemma.task',
        installImpl: (path, {onProgress}) async {
          throw StateError('boom');
        },
      );
      final status = await installer.ensureModelInstalled();
      expect(status, isA<GemmaFailed>());
    });
  });
}
