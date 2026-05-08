import 'package:flutter/material.dart';

import '../../core/routing/app_routes.dart';

class EcoScaffold extends StatelessWidget {
  const EcoScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.currentIndex,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(child: child),
      bottomNavigationBar: currentIndex == null
          ? null
          : NavigationBar(
              selectedIndex: currentIndex!,
              onDestinationSelected: (index) {
                final route = [
                  AppRoutes.dashboard,
                  AppRoutes.guide,
                  AppRoutes.scanner,
                  AppRoutes.rewards,
                  AppRoutes.profile,
                ][index];
                Navigator.pushReplacementNamed(context, route);
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.delete_outline), selectedIcon: Icon(Icons.delete), label: 'Guide'),
                NavigationDestination(icon: Icon(Icons.camera_alt_outlined), selectedIcon: Icon(Icons.camera_alt), label: 'Scan'),
                NavigationDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events), label: 'Rewards'),
                NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
    );
  }
}
