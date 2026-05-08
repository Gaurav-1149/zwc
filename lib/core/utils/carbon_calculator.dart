class CarbonCalculator {
  static double carbonSavedKg(double recycledKg) => recycledKg * 1.72;
  static int pointsForRecycling(double recycledKg) => (recycledKg * 12).round();
  static int pointsForPickup(String wasteType) {
    const highImpact = {'E-Waste', 'Medical Waste', 'Hazardous Waste'};
    return highImpact.contains(wasteType) ? 80 : 40;
  }
}
