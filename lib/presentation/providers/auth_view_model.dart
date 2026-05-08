import '../../data/models/app_user.dart';
import '../../data/repositories/auth_repository.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  AuthViewModel(this._repository);

  final AuthRepository _repository;
  AppUser? _user;
  bool _isAuthenticated = false;
  bool _onboardingSeen = false;

  AppUser? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get onboardingSeen => _onboardingSeen;

  Future<void> bootstrap() async {
    _onboardingSeen = _repository.onboardingSeen;
    _repository.authStateChanges().listen((firebaseUser) async {
      _isAuthenticated = firebaseUser != null;
      _user = await _repository.currentProfile();
      notifyListeners();
    });
    _user = await _repository.currentProfile();
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await _repository.completeOnboarding();
    _onboardingSeen = true;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    return _run(() => _repository.login(email, password));
  }

  Future<bool> register(String name, String email, String password, String phone, String address) async {
    return _run(() => _repository.register(name: name, email: email, password: password, phone: phone, address: address));
  }

  Future<bool> googleSignIn() async => _run(_repository.signInWithGoogle);
  Future<bool> forgotPassword(String email) async => _run(() => _repository.forgotPassword(email));
  Future<void> logout() => _repository.logout();

  Future<bool> _run(Future<void> Function() action) async {
    setLoading(true);
    setError(null);
    try {
      await action();
      return true;
    } catch (error) {
      setError(error.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }
}
