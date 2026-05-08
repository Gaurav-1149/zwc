import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../providers/auth_view_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  final pages = const [
    _OnboardingPage(Icons.delete_sweep, 'Segregate with confidence', 'Search waste categories, bin colors, and disposal steps for everyday items.'),
    _OnboardingPage(Icons.local_shipping, 'Schedule responsible pickups', 'Book recyclable, e-waste, and hazardous pickups with trackable status updates.'),
    _OnboardingPage(Icons.emoji_events, 'Earn rewards together', 'Build streaks, unlock badges, join challenges, and climb your community leaderboard.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) => setState(() => _index = value),
                  children: pages,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (dot) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _index == dot ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _index == dot ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () async {
                  if (_index < pages.length - 1) {
                    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                    return;
                  }
                  await context.read<AuthViewModel>().completeOnboarding();
                  if (context.mounted) Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                child: Text(_index == pages.length - 1 ? 'Get started' : 'Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage(this.icon, this.title, this.message);

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 112, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 32),
        Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
