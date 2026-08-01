/// Estado del bootstrap del modelo on-device.
sealed class GemmaStatus {
  const GemmaStatus();
}

final class GemmaNotInstalled extends GemmaStatus {
  const GemmaNotInstalled();
}

final class GemmaInstalling extends GemmaStatus {
  const GemmaInstalling(this.progress);
  final int progress;
}

final class GemmaReady extends GemmaStatus {
  const GemmaReady();
}

final class GemmaFailed extends GemmaStatus {
  const GemmaFailed(this.reason);
  final String reason;
}
