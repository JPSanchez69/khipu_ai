abstract interface class TtsPort {
  Future<void> speak(String text);
  Future<void> stop();
  Future<void> dispose();
}

abstract interface class SttPort {
  Future<bool> initialize();
  Future<String?> listenOnce({Duration timeout = const Duration(seconds: 8)});
  Future<void> stop();
  Future<void> dispose();
  bool get isAvailable;
}
