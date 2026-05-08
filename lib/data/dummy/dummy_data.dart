import '../models/community_post.dart';
import '../models/recycling_center.dart';
import '../models/reward.dart';
import '../models/scan_result.dart';
import '../models/waste_category.dart';

class DummyData {
  static const wasteCategories = [
    WasteCategory(
      id: 'wet',
      name: 'Wet Waste',
      description: 'Biodegradable kitchen and garden waste that can be composted.',
      examples: ['Vegetable peels', 'Fruit scraps', 'Tea leaves', 'Garden trimmings'],
      instructions: 'Drain liquids, store separately, and send to composting or biogas processing.',
      isRecyclable: true,
      binColorHex: 0xFF2E7D32,
    ),
    WasteCategory(
      id: 'dry',
      name: 'Dry Waste',
      description: 'Clean, dry materials suitable for sorting and recovery.',
      examples: ['Paper', 'Cardboard', 'Metal cans', 'Glass bottles'],
      instructions: 'Keep dry and clean. Flatten cartons and separate sharp glass safely.',
      isRecyclable: true,
      binColorHex: 0xFF1976D2,
    ),
    WasteCategory(
      id: 'plastic',
      name: 'Plastic',
      description: 'Plastic packaging and products that need resin-aware sorting.',
      examples: ['PET bottles', 'Milk packets', 'Food containers', 'Plastic caps'],
      instructions: 'Rinse, dry, crush bottles, and check local acceptance for multilayer plastics.',
      isRecyclable: true,
      binColorHex: 0xFFFFC107,
    ),
    WasteCategory(
      id: 'ewaste',
      name: 'E-Waste',
      description: 'Electrical and electronic items requiring certified handling.',
      examples: ['Phones', 'Chargers', 'Batteries', 'Keyboards'],
      instructions: 'Do not mix with household waste. Use authorized e-waste centers only.',
      isRecyclable: true,
      binColorHex: 0xFF7B1FA2,
    ),
    WasteCategory(
      id: 'medical',
      name: 'Medical Waste',
      description: 'Sanitary or healthcare waste that needs careful containment.',
      examples: ['Masks', 'Bandages', 'Expired medicines', 'Syringes'],
      instructions: 'Seal in marked bags. Hand over to municipal or healthcare collection partners.',
      isRecyclable: false,
      binColorHex: 0xFFD32F2F,
    ),
    WasteCategory(
      id: 'hazardous',
      name: 'Hazardous Waste',
      description: 'Toxic, corrosive, flammable, or reactive household materials.',
      examples: ['Paint', 'Pesticides', 'Tube lights', 'Cleaning chemicals'],
      instructions: 'Keep in original containers and schedule special pickup or drop-off.',
      isRecyclable: false,
      binColorHex: 0xFFEF6C00,
    ),
  ];

  static const badges = [
    RewardBadge(id: 'hero', title: 'Recycling Hero', description: 'Recycle 50 kg of dry waste.', icon: '♻', unlocked: true, requiredPoints: 500),
    RewardBadge(id: 'plastic', title: 'Plastic Warrior', description: 'Divert 100 plastic items.', icon: '🛡', unlocked: true, requiredPoints: 900),
    RewardBadge(id: 'citizen', title: 'Green Citizen', description: 'Maintain a 14-day streak.', icon: '🌿', unlocked: true, requiredPoints: 1200),
    RewardBadge(id: 'champion', title: 'Zero Waste Champion', description: 'Reach 5000 eco points.', icon: '🏆', unlocked: false, requiredPoints: 5000),
  ];

  static const challenges = [
    EcoChallenge(id: 'weekly-segregation', title: '7-Day Segregation Sprint', description: 'Log daily segregation for a full week.', points: 250, progress: 0.72),
    EcoChallenge(id: 'ewaste-drive', title: 'E-Waste Drop Drive', description: 'Submit proof of an authorized e-waste drop.', points: 400, progress: 0.35),
    EcoChallenge(id: 'plastic-free', title: 'Plastic-Free Market Run', description: 'Avoid single-use packaging for 5 purchases.', points: 180, progress: 0.58),
  ];

  static final communityPosts = [
    CommunityPost(
      id: '1',
      authorName: 'Meera Nair',
      authorImage: '',
      text: 'Hosted a society composting demo and diverted 18 kg of wet waste this weekend.',
      imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=900',
      likes: 146,
      comments: 24,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      tags: ['Composting', 'Apartment'],
    ),
    CommunityPost(
      id: '2',
      authorName: 'Rohan Das',
      authorImage: '',
      text: 'Mapped three local scrap collectors and verified their paper and metal rates.',
      imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=900',
      likes: 92,
      comments: 11,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      tags: ['Scrap', 'Map'],
    ),
  ];

  static const centers = [
    RecyclingCenter(id: '1', name: 'GreenLoop Recycling Hub', type: 'Dry Waste Center', address: '12 CMH Road, Bengaluru', distanceKm: 1.8, rating: 4.7, phone: '+91 98765 11111', latitude: 12.9784, longitude: 77.6408),
    RecyclingCenter(id: '2', name: 'EcoByte E-Waste Care', type: 'E-Waste Center', address: 'Old Airport Road, Bengaluru', distanceKm: 3.4, rating: 4.5, phone: '+91 98765 22222', latitude: 12.9609, longitude: 77.6486),
    RecyclingCenter(id: '3', name: 'Saaf City NGO', type: 'NGO Collection Partner', address: 'Domlur Layout, Bengaluru', distanceKm: 4.1, rating: 4.8, phone: '+91 98765 33333', latitude: 12.9611, longitude: 77.6387),
  ];

  static const scanResults = [
    ScanResult(wasteType: 'Plastic', confidence: 0.91, recyclable: true, instructions: 'Rinse, dry, and place in the yellow plastic bin. Avoid mixing food residue.', points: 30),
    ScanResult(wasteType: 'Wet Waste', confidence: 0.87, recyclable: true, instructions: 'Add to compost or schedule organic pickup. Keep liquids drained.', points: 20),
    ScanResult(wasteType: 'E-Waste', confidence: 0.83, recyclable: true, instructions: 'Book certified e-waste pickup. Do not dismantle batteries at home.', points: 80),
  ];
}
