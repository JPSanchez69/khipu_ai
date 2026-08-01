abstract interface class TtsPort {
  Future<void> speak(String text);
  Future<void> stop();
  Future<void> dispose();
  Future<List<TtsVoice>> getVoices();
  Future<void> configure({
    String? name,
    String? locale,
    double? rate,
    double? pitch,
  });
  TtsVoice? get activeVoice;
  double get speechRate;
  double get speechPitch;
}

class TtsVoice {
  const TtsVoice({required this.name, required this.locale});
  final String name;
  final String locale;

  @override
  String toString() => '$name ($locale)';
}

abstract interface class SttPort {
  Future<bool> initialize();
  Future<String?> listenOnce({Duration timeout = const Duration(seconds: 8)});
  Future<void> stop();
  Future<void> dispose();
  bool get isAvailable;
}
