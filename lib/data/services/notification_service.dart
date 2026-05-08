import 'firebase_service.dart';

class NotificationService {
  NotificationService(this._firebase);

  final FirebaseService _firebase;

  Future<void> initialize() => _firebase.configureMessaging();

  Future<void> subscribeToEcoTips() async {
    await _firebase.messaging.subscribeToTopic('eco_tips');
  }
}
