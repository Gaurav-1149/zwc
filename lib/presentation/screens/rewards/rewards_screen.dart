import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_view_model.dart';
import '../../providers/rewards_view_model.dart';
import '../../widgets/eco_scaffold.dart';
import '../../widgets/section_header.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = context.watch<RewardsViewModel>();
    final user = context.watch<AuthViewModel>().user;
    return EcoScaffold(
      title: 'Eco Rewards',
      currentIndex: 3,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.eco, size: 48),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user?.ecoPoints ?? 2840} points', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                      const Text('Redeem for coupons, compost kits, and green certificates.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Badges'),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.15, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemCount: rewards.badges.length,
            itemBuilder: (context, index) {
              final badge = rewards.badges[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(badge.icon, style: const TextStyle(fontSize: 30)),
                      const Spacer(),
                      Text(badge.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text(badge.unlocked ? 'Unlocked' : '${badge.requiredPoints} points needed'),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Weekly challenges'),
          ...rewards.challenges.map((challenge) => Card(
                child: ListTile(
                  title: Text(challenge.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(challenge.description),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: challenge.progress),
                    ],
                  ),
                  trailing: Chip(label: Text('+${challenge.points}')),
                ),
              )),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Marketplace'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.workspace_premium_outlined),
              title: const Text('Green certificate concept'),
              subtitle: const Text('Generate a verified monthly impact certificate for employers or housing societies.'),
              trailing: FilledButton.tonal(onPressed: () {}, child: const Text('Preview')),
            ),
          ),
        ],
      ),
    );
  }
}
