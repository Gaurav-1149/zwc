import '../../data/models/pickup_request.dart';
import '../../data/repositories/pickup_repository.dart';
import 'base_view_model.dart';

class PickupViewModel extends BaseViewModel {
  PickupViewModel(this._repository);

  final PickupRepository _repository;
  List<PickupRequest> _pickups = [];

  List<PickupRequest> get pickups => _pickups;
  PickupRequest? get upcoming => _pickups.where((pickup) => pickup.scheduledAt.isAfter(DateTime.now())).firstOrNull;

  Future<void> load() async {
    setLoading(true);
    _pickups = await _repository.fetchPickups();
    setLoading(false);
  }

  Future<void> schedule(String wasteType, String address, DateTime scheduledAt, String notes) async {
    setLoading(true);
    final pickup = await _repository.schedule(wasteType: wasteType, address: address, scheduledAt: scheduledAt, notes: notes);
    _pickups = [pickup, ..._pickups];
    setLoading(false);
  }
}

extension FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
