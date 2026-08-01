import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

import '../../domain/ports/voice_ports.dart';

class SpeechToTextService implements SttPort {
  final SpeechToText _speech = SpeechToText();
  var _available = false;

  @override
  bool get isAvailable => _available;

  @override
  Future<bool> initialize() async {
    _available = await _speech.initialize(
      onError: (_) {},
      onStatus: (_) {},
    );
    return _available;
  }

  @override
  Future<String?> listenOnce({
    Duration timeout = const Duration(seconds: 8),
  }) async {
    if (!_available) {
      final ok = await initialize();
      if (!ok) return null;
    }

    final completer = Completer<String?>();
    var last = '';

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
        localeId: 'es_ES',
      ),
    );

    return completer.future.timeout(
      timeout + const Duration(seconds: 2),
      onTimeout: () async {
        await _speech.stop();
        return last.isEmpty ? null : last;
      },
    );
  }

  @override
  Future<void> stop() => _speech.stop();

  @override
  Future<void> dispose() async {
    await _speech.cancel();
  }
}
