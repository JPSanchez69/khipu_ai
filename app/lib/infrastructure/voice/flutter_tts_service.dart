import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../domain/ports/voice_ports.dart';
import 'tts_chunker.dart';

/// TTS del sistema con voz ES preferida + chunking (sin deps neuronales).
class FlutterTtsService implements TtsPort {
  FlutterTtsService() {
    _init();
  }

  final FlutterTts _tts = FlutterTts();
  var _ready = false;
  var _cancelled = false;

  Future<void> _init() async {
    try {
      await _tts.awaitSpeakCompletion(true);
      await _tts.setLanguage('es-ES');
      // Más pausado = menos “robot” en motores del sistema.
      await _tts.setSpeechRate(0.42);
      await _tts.setVolume(1.0);
      await _tts.setPitch(0.95);
      await _preferSpanishVoice();
      _ready = true;
    } catch (e) {
      debugPrint('Khipu: TTS init parcial: $e');
      _ready = true;
    }
  }

  Future<void> _preferSpanishVoice() async {
    try {
      final raw = await _tts.getVoices;
      if (raw is! List) return;
      final voices = raw
          .whereType<Map>()
          .map((m) => m.map((k, v) => MapEntry(k.toString(), v.toString())))
          .where((m) {
            final locale = (m['locale'] ?? '').toLowerCase();
            return locale.startsWith('es');
          })
          .toList();
      if (voices.isEmpty) return;

      Map<String, String> pick = voices.first;
      for (final preferred in ['es-mx', 'es-es', 'es-us', 'es-ar']) {
        final match = voices.where(
          (v) => (v['locale'] ?? '').toLowerCase().startsWith(preferred),
        );
        if (match.isNotEmpty) {
          pick = match.first;
          break;
        }
      }

      final name = pick['name'];
      final locale = pick['locale'];
      if (name != null && locale != null) {
        await _tts.setVoice({'name': name, 'locale': locale});
        debugPrint('Khipu: TTS voz $name ($locale)');
      }
    } catch (e) {
      debugPrint('Khipu: no se pudo elegir voz ES: $e');
    }
  }

  @override
  Future<void> speak(String text) async {
    if (!_ready) await _init();
    _cancelled = false;
    final chunks = TtsChunker.split(text);
    if (chunks.isEmpty) return;

    for (final chunk in chunks) {
      if (_cancelled) break;
      await _tts.speak(chunk);
      // Breve silencio entre chunks (prosodia más natural).
      if (!_cancelled && chunks.length > 1) {
        await Future<void>.delayed(const Duration(milliseconds: 120));
      }
    }
  }

  @override
  Future<void> stop() async {
    _cancelled = true;
    await _tts.stop();
  }

  @override
  Future<void> dispose() async {
    _cancelled = true;
    await _tts.stop();
  }
}
