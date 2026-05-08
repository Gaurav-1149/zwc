class WasteCategory {
  const WasteCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.examples,
    required this.instructions,
    required this.isRecyclable,
    required this.binColorHex,
  });

  final String id;
  final String name;
  final String description;
  final List<String> examples;
  final String instructions;
  final bool isRecyclable;
  final int binColorHex;

  factory WasteCategory.fromMap(String id, Map<String, dynamic> map) {
    return WasteCategory(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      examples: List<String>.from(map['examples'] ?? const []),
      instructions: map['instructions'] ?? '',
      isRecyclable: map['isRecyclable'] ?? false,
      binColorHex: map['binColorHex'] ?? 0xFF4CAF50,
    );
  }
}
