import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constants/app_collections.dart';
import '../models/app_user.dart';
import '../services/firebase_service.dart';
import '../services/local_cache_service.dart';

class AuthRepository {
  AuthRepository(this._firebase, this._cache);

  final FirebaseService _firebase;
  final LocalCacheService _cache;

  Stream<User?> authStateChanges() => _firebase.auth.authStateChanges();
  bool get onboardingSeen => _cache.onboardingSeen;
  Future<void> completeOnboarding() => _cache.setOnboardingSeen();

  Future<AppUser> currentProfile() async {
    final user = _firebase.auth.currentUser;
    if (user == null) return AppUser.demo();
    final doc = await _firebase.firestore.collection(AppCollections.users).doc(user.uid).get();
    if (!doc.exists) {
      final profile = AppUser.demo().copyWith(
        id: user.uid,
        name: user.displayName ?? 'Eco Citizen',
        email: user.email ?? '',
      );
      await _firebase.firestore.collection(AppCollections.users).doc(user.uid).set(profile.toMap());
      return profile;
    }
    return AppUser.fromMap(doc.id, doc.data() ?? {});
  }

  Future<void> login(String email, String password) async {
    await _firebase.auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    final credential = await _firebase.auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
    await credential.user?.updateDisplayName(name);
    final profile = AppUser(
      id: credential.user!.uid,
      name: name,
      email: email.trim(),
      phone: phone,
      address: address,
      ecoPoints: 100,
      wasteRecycledKg: 0,
      streakDays: 1,
      profileImage: '',
    );
    await _firebase.firestore.collection(AppCollections.users).doc(profile.id).set(profile.toMap());
  }

  Future<void> signInWithGoogle() async {
    final account = await GoogleSignIn().signIn();
    if (account == null) return;
    final auth = await account.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
    await _firebase.auth.signInWithCredential(credential);
  }

  Future<void> forgotPassword(String email) async {
    await _firebase.auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> logout() => _firebase.auth.signOut();
}
