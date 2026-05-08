import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/community_repository.dart';
import 'data/repositories/pickup_repository.dart';
import 'data/repositories/rewards_repository.dart';
import 'data/repositories/waste_repository.dart';
import 'data/services/firebase_service.dart';
import 'data/services/local_cache_service.dart';
import 'data/services/mock_ai_classifier_service.dart';
import 'firebase_options.dart';
import 'presentation/providers/app_state.dart';
import 'presentation/providers/auth_view_model.dart';
import 'presentation/providers/community_view_model.dart';
import 'presentation/providers/pickup_view_model.dart';
import 'presentation/providers/rewards_view_model.dart';
import 'presentation/providers/scanner_view_model.dart';
import 'presentation/providers/settings_view_model.dart';
import 'presentation/providers/waste_guide_view_model.dart';
import 'presentation/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final cache = LocalCacheService();
  await cache.init();
  runApp(ZeroWasteCitizenApp(cache: cache));
}

class ZeroWasteCitizenApp extends StatelessWidget {
  const ZeroWasteCitizenApp({super.key, required this.cache});

  final LocalCacheService cache;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseService()),
        Provider.value(value: cache),
        Provider(create: (_) => MockAiClassifierService()),
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel(cache)..load()),
        Provider(create: (context) => AuthRepository(context.read<FirebaseService>(), cache)),
        Provider(create: (context) => WasteRepository(context.read<FirebaseService>(), cache)),
        Provider(create: (context) => PickupRepository(context.read<FirebaseService>(), cache)),
        Provider(create: (context) => RewardsRepository(context.read<FirebaseService>())),
        Provider(create: (context) => CommunityRepository(context.read<FirebaseService>())),
        ChangeNotifierProvider(create: (context) => AuthViewModel(context.read<AuthRepository>())..bootstrap()),
        ChangeNotifierProvider(create: (context) => WasteGuideViewModel(context.read<WasteRepository>())..load()),
        ChangeNotifierProvider(create: (context) => PickupViewModel(context.read<PickupRepository>())..load()),
        ChangeNotifierProvider(create: (context) => RewardsViewModel(context.read<RewardsRepository>())..load()),
        ChangeNotifierProvider(create: (context) => CommunityViewModel(context.read<CommunityRepository>())..load()),
        ChangeNotifierProvider(
          create: (context) => ScannerViewModel(
            context.read<MockAiClassifierService>(),
            context.read<RewardsRepository>(),
          ),
        ),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Zero Waste Citizen',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.themeMode,
            locale: settings.locale,
            supportedLocales: const [Locale('en'), Locale('hi'), Locale('ta')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
