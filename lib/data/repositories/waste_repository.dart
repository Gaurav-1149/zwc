import '../../core/constants/app_collections.dart';
import '../dummy/dummy_data.dart';
import '../models/waste_category.dart';
import '../services/firebase_service.dart';
import '../services/local_cache_service.dart';

class WasteRepository {
  WasteRepository(this._firebase, this._cache);

  final FirebaseService _firebase;
  final LocalCacheService _cache;

  Future<List<WasteCategory>> fetchCategories() async {
    try {
      final snapshot = await _firebase.firestore.collection(AppCollections.reports).doc('wasteGuide').collection('categories').get();
      if (snapshot.docs.isEmpty) return DummyData.wasteCategories;
      return snapshot.docs.map((doc) => WasteCategory.fromMap(doc.id, doc.data())).toList();
    } catch (_) {
      return DummyData.wasteCategories;
    }
  }
}
