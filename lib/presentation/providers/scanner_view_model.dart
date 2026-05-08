import '../../data/models/scan_result.dart';
import '../../data/repositories/rewards_repository.dart';
import '../../data/services/mock_ai_classifier_service.dart';
import 'base_view_model.dart';

class ScannerViewModel extends BaseViewModel {
  ScannerViewModel(this._classifier, this._rewards);

  final MockAiClassifierService _classifier;
  final RewardsRepository _rewards;
  ScanResult? result;

  Future<void> scanDemo() async {
    setLoading(true);
    result = await _classifier.classifyRandomDemo();
    await _rewards.awardPoints(result!.points, 'AI waste scan');
    setLoading(false);
  }

  Future<void> classifyImage(String path) async {
    setLoading(true);
    result = await _classifier.classifyImage(path);
    await _rewards.awardPoints(result!.points, 'AI waste scan');
    setLoading(false);
  }
}
