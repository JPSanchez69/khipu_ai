import 'package:flutter_tts/flutter_tts.dart';

import '../../domain/ports/voice_ports.dart';

class FlutterTtsService implements TtsPort {
  FlutterTtsService() {
    _tts.setLanguage('es-ES');
    _tts.setSpeechRate(0.45);
    _tts.setVolume(1.0);
    _tts.setPitch(1.0);
  }

  final FlutterTts _tts = FlutterTts();

  @override
  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  Future<void> stop() => _tts.stop();

  @override
  Future<void> dispose() async {
    await _tts.stop();
  }
}
