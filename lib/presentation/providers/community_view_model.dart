import '../../data/models/community_post.dart';
import '../../data/repositories/community_repository.dart';
import 'base_view_model.dart';

class CommunityViewModel extends BaseViewModel {
  CommunityViewModel(this._repository);

  final CommunityRepository _repository;
  List<CommunityPost> posts = [];

  Future<void> load() async {
    setLoading(true);
    posts = await _repository.fetchPosts();
    setLoading(false);
  }
}
