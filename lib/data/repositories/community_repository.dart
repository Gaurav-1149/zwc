import '../../core/constants/app_collections.dart';
import '../dummy/dummy_data.dart';
import '../models/community_post.dart';
import '../services/firebase_service.dart';

class CommunityRepository {
  CommunityRepository(this._firebase);

  final FirebaseService _firebase;

  Future<List<CommunityPost>> fetchPosts() async {
    try {
      final snapshot = await _firebase.firestore.collection(AppCollections.communityPosts).orderBy('createdAt', descending: true).limit(25).get();
      if (snapshot.docs.isEmpty) return DummyData.communityPosts;
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CommunityPost(
          id: doc.id,
          authorName: data['authorName'] ?? '',
          authorImage: data['authorImage'] ?? '',
          text: data['text'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          likes: data['likes'] ?? 0,
          comments: data['comments'] ?? 0,
          createdAt: DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
          tags: List<String>.from(data['tags'] ?? const []),
        );
      }).toList();
    } catch (_) {
      return DummyData.communityPosts;
    }
  }
}
