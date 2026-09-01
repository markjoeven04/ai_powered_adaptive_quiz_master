import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'core/providers/app_providers.dart';
import 'features/splash/splash_screen.dart';
import 'features/navigation/main_nav_shell.dart';
import 'features/grade_level/grade_level_screen.dart';
import 'features/difficulty/difficulty_screen.dart';
import 'features/quiz/quiz_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure portrait orientation and clean status bar overlay
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  final storageService = await StorageService.init();

  runApp(
    ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storageService),
      ],
      child: const BrightSparkApp(),
    ),
  );
}

class BrightSparkApp extends StatelessWidget {
  const BrightSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppStrings.appName} ${AppStrings.appSubtitle}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const MainNavShell(),
        '/grade-level': (context) => const GradeLevelScreen(),
        '/difficulty': (context) => const DifficultyScreen(),
        '/quiz': (context) => const QuizScreen(),
      },
    );
  }
}
