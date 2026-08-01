/// Divide texto largo en frases para TTS más natural en móviles.
class TtsChunker {
  TtsChunker._();

  /// Parte por oraciones; si una oración supera [maxChars], corta por palabras.
  static List<String> split(String text, {int maxChars = 160}) {
    final normalized = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (normalized.isEmpty) return const [];

    final sentences = <String>[];
    final buffer = StringBuffer();
    for (var i = 0; i < normalized.length; i++) {
      buffer.write(normalized[i]);
      final ch = normalized[i];
      final end = i == normalized.length - 1;
      final boundary = ch == '.' || ch == '!' || ch == '?' || ch == '…';
      if (boundary || end) {
        final piece = buffer.toString().trim();
        if (piece.isNotEmpty) sentences.add(piece);
        buffer.clear();
      }
    }

    if (sentences.isEmpty) {
      return _wrapByWords(normalized, maxChars);
    }

    final chunks = <String>[];
    for (final sentence in sentences) {
      if (sentence.length <= maxChars) {
        chunks.add(sentence);
      } else {
        chunks.addAll(_wrapByWords(sentence, maxChars));
      }
    }
    return chunks;
  }

  static List<String> _wrapByWords(String text, int maxChars) {
    final words = text.split(' ');
    final out = <String>[];
    var current = StringBuffer();
    for (final word in words) {
      if (word.isEmpty) continue;
      if (current.isEmpty) {
        current.write(word);
        continue;
      }
      if (current.length + 1 + word.length <= maxChars) {
        current.write(' ');
        current.write(word);
      } else {
        out.add(current.toString());
        current = StringBuffer(word);
      }
    }
    if (current.isNotEmpty) out.add(current.toString());
    return out;
  }
}
