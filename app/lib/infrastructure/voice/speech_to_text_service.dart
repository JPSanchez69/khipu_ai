import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

import '../../domain/ports/voice_ports.dart';
import 'stt_locale.dart';

class SpeechToTextService implements SttPort {
  SpeechToTextService({SpeechToText? speech}) : _speech = speech ?? SpeechToText();

  final SpeechToText _speech;
  var _available = false;
  String? _localeId;
  String? _lastError;

  @override
  bool get isAvailable => _available;

  @override
  Future<bool> initialize() async {
    _lastError = null;
    _available = await _speech.initialize(
      onError: (e) {
        _lastError = e.errorMsg;
      },
      onStatus: (_) {},
    );
    if (_available) {
      final locales = await _speech.locales();
      final system = await _speech.systemLocale();
      _localeId = pickSpanishLocaleId(
        locales.map((l) => l.localeId),
        systemLocaleId: system?.localeId,
      );
    }
    return _available;
  }

  @override
  Future<String?> listenOnce({
    Duration timeout = const Duration(seconds: 8),
  }) async {
    if (!_available) {
      final ok = await initialize();
      if (!ok) {
        throw SttException(
          _lastError ??
              'Reconocimiento de voz no disponible. '
                  'Revisa el permiso de micrófono o el paquete de voz.',
        );
      }
    }

    final completer = Completer<String?>();
    var last = '';
    _lastError = null;

    await _speech.listen(
      onResult: (result) {
        last = result.recognizedWords;
        if (result.finalResult && !completer.isCompleted) {
          completer.complete(last.isEmpty ? null : last);
        }
      },
      listenOptions: SpeechListenOptions(
        listenFor: timeout,
        pauseFor: const Duration(seconds: 2),
        localeId: _localeId,
      ),
    );

    // Poll errors from onError while listening.
    final errorTicker = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (_lastError != null && !completer.isCompleted) {
        completer.completeError(SttException(_humanizeSttError(_lastError!)));
      }
    });

    try {
      return await completer.future.timeout(
        timeout + const Duration(seconds: 2),
        onTimeout: () async {
          await _speech.stop();
          if (_lastError != null) {
            throw SttException(_humanizeSttError(_lastError!));
          }
          return last.isEmpty ? null : last;
        },
      );
    } on SttException {
      await _speech.stop();
      rethrow;
    } finally {
      errorTicker.cancel();
    }
  }

  String _humanizeSttError(String code) {
    final c = code.toLowerCase();
    if (c.contains('permission') || c.contains('denied')) {
      return 'Permiso de micrófono denegado';
    }
    if (c.contains('language')) {
      return 'Idioma de voz no soportado. Instala el paquete de español.';
    }
    if (c.contains('no_match') || c.contains('speech_timeout')) {
      return 'No te escuché. Intenta de nuevo.';
    }
    if (c.contains('network')) {
      return 'STT necesita red o el paquete de voz offline.';
    }
    return 'Error de voz: $code';
  }

  @override
  Future<void> stop() => _speech.stop();

  @override
  Future<void> dispose() async {
    await _speech.cancel();
  }
}
