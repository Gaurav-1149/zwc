class RecyclingCenter {
  const RecyclingCenter({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.distanceKm,
    required this.rating,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String type;
  final String address;
  final double distanceKm;
  final double rating;
  final String phone;
  final double latitude;
  final double longitude;
}
