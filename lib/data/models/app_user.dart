class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.ecoPoints,
    required this.wasteRecycledKg,
    required this.streakDays,
    required this.profileImage,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final int ecoPoints;
  final double wasteRecycledKg;
  final int streakDays;
  final String profileImage;

  factory AppUser.demo() => const AppUser(
        id: 'demo-user',
        name: 'Aarav Sharma',
        email: 'aarav@example.com',
        phone: '+91 98765 43210',
        address: 'Indiranagar, Bengaluru',
        ecoPoints: 2840,
        wasteRecycledKg: 126.5,
        streakDays: 18,
        profileImage: '',
      );

  factory AppUser.fromMap(String id, Map<String, dynamic> map) => AppUser(
        id: id,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        phone: map['phone'] ?? '',
        address: map['address'] ?? '',
        ecoPoints: map['ecoPoints'] ?? 0,
        wasteRecycledKg: (map['wasteRecycledKg'] ?? 0).toDouble(),
        streakDays: map['streakDays'] ?? 0,
        profileImage: map['profileImage'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'ecoPoints': ecoPoints,
        'wasteRecycledKg': wasteRecycledKg,
        'streakDays': streakDays,
        'profileImage': profileImage,
      };

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    int? ecoPoints,
    double? wasteRecycledKg,
    int? streakDays,
    String? profileImage,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      ecoPoints: ecoPoints ?? this.ecoPoints,
      wasteRecycledKg: wasteRecycledKg ?? this.wasteRecycledKg,
      streakDays: streakDays ?? this.streakDays,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
