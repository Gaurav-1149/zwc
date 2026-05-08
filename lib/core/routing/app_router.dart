import 'package:flutter/material.dart';

import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/onboarding_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/community/community_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/guide/waste_guide_screen.dart';
import '../../presentation/screens/nearby/nearby_centers_screen.dart';
import '../../presentation/screens/pickup/pickup_history_screen.dart';
import '../../presentation/screens/pickup/pickup_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/rewards/rewards_screen.dart';
import '../../presentation/screens/scanner/scanner_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      AppRoutes.splash: (_) => const SplashScreen(),
      AppRoutes.onboarding: (_) => const OnboardingScreen(),
      AppRoutes.login: (_) => const LoginScreen(),
      AppRoutes.register: (_) => const RegisterScreen(),
      AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
      AppRoutes.dashboard: (_) => const DashboardScreen(),
      AppRoutes.guide: (_) => const WasteGuideScreen(),
      AppRoutes.scanner: (_) => const ScannerScreen(),
      AppRoutes.pickup: (_) => const PickupScreen(),
      AppRoutes.pickupHistory: (_) => const PickupHistoryScreen(),
      AppRoutes.rewards: (_) => const RewardsScreen(),
      AppRoutes.community: (_) => const CommunityScreen(),
      AppRoutes.nearby: (_) => const NearbyCentersScreen(),
      AppRoutes.profile: (_) => const ProfileScreen(),
      AppRoutes.settings: (_) => const SettingsScreen(),
    };
    return MaterialPageRoute(
      settings: settings,
      builder: routes[settings.name] ?? (_) => const DashboardScreen(),
    );
  }
}
