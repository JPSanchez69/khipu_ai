/// Selección de locale STT en español (pura, testeable).
String? pickSpanishLocaleId(
  Iterable<String> availableLocaleIds, {
  String? systemLocaleId,
}) {
  final ids = availableLocaleIds.toList();
  if (ids.isEmpty) return systemLocaleId;

  const preferred = ['es_PE', 'es_MX', 'es_US', 'es_ES'];
  for (final p in preferred) {
    if (ids.any((id) => id.toLowerCase() == p.toLowerCase())) {
      return ids.firstWhere((id) => id.toLowerCase() == p.toLowerCase());
    }
  }

  final anyEs = ids.where((id) => id.toLowerCase().startsWith('es'));
  if (anyEs.isNotEmpty) return anyEs.first;

  return systemLocaleId ?? ids.first;
}
