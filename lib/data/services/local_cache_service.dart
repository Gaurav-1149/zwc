import 'package:shared_preferences/shared_preferences.dart';

class LocalCacheService {
  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool get onboardingSeen => _preferences?.getBool('onboardingSeen') ?? false;
  Future<void> setOnboardingSeen() async => _preferences?.setBool('onboardingSeen', true);

  bool get darkMode => _preferences?.getBool('darkMode') ?? false;
  Future<void> setDarkMode(bool value) async => _preferences?.setBool('darkMode', value);

  String get languageCode => _preferences?.getString('languageCode') ?? 'en';
  Future<void> setLanguageCode(String value) async => _preferences?.setString('languageCode', value);
}
