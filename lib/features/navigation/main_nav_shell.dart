import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../welcome/welcome_screen.dart';
import '../quizzes_tab/quiz_history_screen.dart';
import '../progress_tab/progress_screen.dart';
import '../badges_tab/badges_screen.dart';

class MainNavShell extends StatefulWidget {
  const MainNavShell({super.key});

  @override
  State<MainNavShell> createState() => _MainNavShellState();
}

class _MainNavShellState extends State<MainNavShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    WelcomeScreen(),
    QuizHistoryScreen(),
    ProgressScreen(),
    BadgesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: AppColors.primaryContainer.withValues(alpha: 0.12),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.auto_stories_outlined, color: AppColors.onSurfaceVariant),
                selectedIcon: Icon(Icons.auto_stories_rounded, color: AppColors.primary),
                label: 'Learn',
              ),
              NavigationDestination(
                icon: Icon(Icons.quiz_outlined, color: AppColors.onSurfaceVariant),
                selectedIcon: Icon(Icons.quiz_rounded, color: AppColors.primary),
                label: 'Quizzes',
              ),
              NavigationDestination(
                icon: Icon(Icons.insights_outlined, color: AppColors.onSurfaceVariant),
                selectedIcon: Icon(Icons.insights_rounded, color: AppColors.primary),
                label: 'Progress',
              ),
              NavigationDestination(
                icon: Icon(Icons.military_tech_outlined, color: AppColors.onSurfaceVariant),
                selectedIcon: Icon(Icons.military_tech_rounded, color: AppColors.primary),
                label: 'Badges',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
