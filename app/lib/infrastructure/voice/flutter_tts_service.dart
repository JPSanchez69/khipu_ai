import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../domain/ports/voice_ports.dart';
import 'tts_chunker.dart';

/// Usa Web Speech API en Chrome y el motor TTS del sistema en Android.
class FlutterTtsService implements TtsPort {
  FlutterTtsService() {
    _initializing = _init();
  }

  final FlutterTts _tts = FlutterTts();
  late final Future<void> _initializing;
  var _ready = false;
  var _cancelled = false;
  double _rate = 0.52;
  double _pitch = 1.0;
  TtsVoice? _activeVoice;

  @override
  TtsVoice? get activeVoice => _activeVoice;
  @override
  double get speechRate => _rate;
  @override
  double get speechPitch => _pitch;

  Future<void> _init() async {
    try {
      await _tts.awaitSpeakCompletion(true);
      await _tts.setLanguage('es-PE');
      await _tts.setSpeechRate(_rate);
      await _tts.setVolume(1.0);
      await _tts.setPitch(_pitch);
      await _preferSpanishVoice();
    } catch (e) {
      debugPrint('Khipu: inicialización TTS parcial: $e');
    } finally {
      _ready = true;
    }
  }

  @override
  Future<List<TtsVoice>> getVoices() async {
    final raw = await _tts.getVoices;
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map(
          (voice) => TtsVoice(
            name: (voice['name'] ?? '').toString(),
            locale: (voice['locale'] ?? '').toString(),
          ),
        )
        .where(
          (voice) =>
              voice.name.isNotEmpty &&
              voice.locale.toLowerCase().startsWith('es'),
        )
        .toList();
  }

  Future<void> _preferSpanishVoice() async {
    final voices = await getVoices();
    if (voices.isEmpty) return;
    var selected = voices.first;
    for (final preferred in ['es-pe', 'es-mx', 'es-es', 'es-us', 'es-ar']) {
      final matches = voices.where(
        (voice) => voice.locale.toLowerCase().startsWith(preferred),
      );
      if (matches.isNotEmpty) {
        selected = matches.first;
        break;
      }
    }
    await _setVoice(selected.name, selected.locale);
  }

  @override
  Future<void> configure({
    String? name,
    String? locale,
    double? rate,
    double? pitch,
  }) async {
    if (!_ready) await _initializing;
    if (rate != null) {
      _rate = rate.clamp(0.30, 0.75);
      await _tts.setSpeechRate(_rate);
    }
    if (pitch != null) {
      _pitch = pitch.clamp(0.75, 1.25);
      await _tts.setPitch(_pitch);
    }
    if (name != null && locale != null) {
      await _setVoice(name, locale);
    }
  }

  Future<void> _setVoice(String name, String locale) async {
    await _tts.setLanguage(locale);
    await _tts.setVoice({'name': name, 'locale': locale});
    _activeVoice = TtsVoice(name: name, locale: locale);
    debugPrint('Khipu: voz activa $_activeVoice, velocidad $_rate');
  }

  @override
  Future<void> speak(String text) async {
    if (!_ready) await _initializing;
    _cancelled = false;
    final chunks = TtsChunker.split(text);
    for (final chunk in chunks) {
      if (_cancelled) break;
      await _tts.speak(chunk);
      if (!_cancelled && chunks.length > 1) {
        await Future<void>.delayed(const Duration(milliseconds: 60));
      }
    }
  }

  @override
  Future<void> stop() async {
    _cancelled = true;
    await _tts.stop();
  }

  @override
  Future<void> dispose() => stop();
}
