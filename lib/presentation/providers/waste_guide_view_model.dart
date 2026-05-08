import '../../data/models/waste_category.dart';
import '../../data/repositories/waste_repository.dart';
import 'base_view_model.dart';

class WasteGuideViewModel extends BaseViewModel {
  WasteGuideViewModel(this._repository);

  final WasteRepository _repository;
  List<WasteCategory> _categories = [];
  String _query = '';

  List<WasteCategory> get categories {
    if (_query.isEmpty) return _categories;
    final lower = _query.toLowerCase();
    return _categories.where((category) {
      return category.name.toLowerCase().contains(lower) ||
          category.examples.any((example) => example.toLowerCase().contains(lower));
    }).toList();
  }

  Future<void> load() async {
    setLoading(true);
    _categories = await _repository.fetchCategories();
    setLoading(false);
  }

  void search(String value) {
    _query = value;
    notifyListeners();
  }
}
