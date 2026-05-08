import '../../data/models/reward.dart';
import '../../data/repositories/rewards_repository.dart';
import 'base_view_model.dart';

class RewardsViewModel extends BaseViewModel {
  RewardsViewModel(this._repository);

  final RewardsRepository _repository;
  List<RewardBadge> badges = [];
  List<EcoChallenge> challenges = [];

  Future<void> load() async {
    setLoading(true);
    badges = await _repository.fetchBadges();
    challenges = await _repository.fetchChallenges();
    setLoading(false);
  }
}
