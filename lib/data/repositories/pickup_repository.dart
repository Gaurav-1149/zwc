import 'package:uuid/uuid.dart';

import '../../core/constants/app_collections.dart';
import '../models/pickup_request.dart';
import '../services/firebase_service.dart';
import '../services/local_cache_service.dart';

class PickupRepository {
  PickupRepository(this._firebase, this._cache);

  final FirebaseService _firebase;
  final LocalCacheService _cache;
  final _uuid = const Uuid();

  Future<List<PickupRequest>> fetchPickups() async {
    try {
      final uid = _firebase.auth.currentUser?.uid ?? 'demo-user';
      final snapshot = await _firebase.firestore
          .collection(AppCollections.pickups)
          .where('userId', isEqualTo: uid)
          .orderBy('scheduledAt', descending: true)
          .get();
      if (snapshot.docs.isEmpty) return _demoPickups(uid);
      return snapshot.docs.map((doc) => PickupRequest.fromMap(doc.id, doc.data())).toList();
    } catch (_) {
      return _demoPickups(_firebase.auth.currentUser?.uid ?? 'demo-user');
    }
  }

  Future<PickupRequest> schedule({
    required String wasteType,
    required String address,
    required DateTime scheduledAt,
    required String notes,
  }) async {
    final uid = _firebase.auth.currentUser?.uid ?? 'demo-user';
    final pickup = PickupRequest(
      id: _uuid.v4(),
      userId: uid,
      wasteType: wasteType,
      address: address,
      scheduledAt: scheduledAt,
      status: PickupStatus.pending,
      notes: notes,
    );
    try {
      await _firebase.firestore.collection(AppCollections.pickups).doc(pickup.id).set(pickup.toMap());
    } catch (_) {}
    return pickup;
  }

  List<PickupRequest> _demoPickups(String uid) => [
        PickupRequest(
          id: 'demo-1',
          userId: uid,
          wasteType: 'Plastic',
          address: 'Indiranagar, Bengaluru',
          scheduledAt: DateTime.now().add(const Duration(days: 1, hours: 2)),
          status: PickupStatus.accepted,
          notes: 'Three bags of cleaned bottles.',
        ),
        PickupRequest(
          id: 'demo-2',
          userId: uid,
          wasteType: 'E-Waste',
          address: 'Indiranagar, Bengaluru',
          scheduledAt: DateTime.now().subtract(const Duration(days: 5)),
          status: PickupStatus.completed,
          notes: 'Old charger and headphones.',
        ),
      ];
}
