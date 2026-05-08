import '../dummy/dummy_data.dart';
import '../models/reward.dart';
import '../services/firebase_service.dart';

class RewardsRepository {
  RewardsRepository(this._firebase);

  final FirebaseService _firebase;

  Future<List<RewardBadge>> fetchBadges() async => DummyData.badges;
  Future<List<EcoChallenge>> fetchChallenges() async => DummyData.challenges;

  Future<void> awardPoints(int points, String reason) async {
    final uid = _firebase.auth.currentUser?.uid;
    if (uid == null) return;
    await _firebase.firestore.collection('users').doc(uid).collection('pointEvents').add({
      'points': points,
      'reason': reason,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }
}
