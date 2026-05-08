enum PickupStatus { pending, accepted, inTransit, completed }

class PickupRequest {
  const PickupRequest({
    required this.id,
    required this.userId,
    required this.wasteType,
    required this.address,
    required this.scheduledAt,
    required this.status,
    required this.notes,
  });

  final String id;
  final String userId;
  final String wasteType;
  final String address;
  final DateTime scheduledAt;
  final PickupStatus status;
  final String notes;

  factory PickupRequest.fromMap(String id, Map<String, dynamic> map) {
    return PickupRequest(
      id: id,
      userId: map['userId'] ?? '',
      wasteType: map['wasteType'] ?? '',
      address: map['address'] ?? '',
      scheduledAt: DateTime.tryParse(map['scheduledAt'] ?? '') ?? DateTime.now(),
      status: PickupStatus.values.firstWhere(
        (status) => status.name == map['status'],
        orElse: () => PickupStatus.pending,
      ),
      notes: map['notes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'wasteType': wasteType,
        'address': address,
        'scheduledAt': scheduledAt.toIso8601String(),
        'status': status.name,
        'notes': notes,
      };
}
