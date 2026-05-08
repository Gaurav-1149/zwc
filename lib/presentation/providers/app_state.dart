import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int _currentTab = 0;
  int get currentTab => _currentTab;

  void setTab(int index) {
    _currentTab = index;
    notifyListeners();
  }
}
