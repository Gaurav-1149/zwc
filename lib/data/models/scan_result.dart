class ScanResult {
  const ScanResult({
    required this.wasteType,
    required this.confidence,
    required this.recyclable,
    required this.instructions,
    required this.points,
  });

  final String wasteType;
  final double confidence;
  final bool recyclable;
  final String instructions;
  final int points;
}
