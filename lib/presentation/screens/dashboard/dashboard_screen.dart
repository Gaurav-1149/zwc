import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/carbon_calculator.dart';
import '../../providers/auth_view_model.dart';
import '../../providers/pickup_view_model.dart';
import '../../widgets/animated_metric_card.dart';
import '../../widgets/eco_scaffold.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/section_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthViewModel>().user;
    final pickup = context.watch<PickupViewModel>().upcoming;
    final recycled = user?.wasteRecycledKg ?? 126.5;
    final carbon = CarbonCalculator.carbonSavedKg(recycled);
    return EcoScaffold(
      title: 'Dashboard',
      currentIndex: 0,
      actions: [
        IconButton(
          tooltip: 'Notifications',
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        IconButton(
          tooltip: 'Settings',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () => context.read<PickupViewModel>().load(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Hello, ${user?.name.split(' ').first ?? 'Citizen'}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            const Text('Your city impact is growing one sorted item at a time.'),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: MediaQuery.sizeOf(context).width > 700 ? 4 : 2,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                AnimatedMetricCard(title: 'Eco points', value: '${user?.ecoPoints ?? 2840}', icon: Icons.eco, color: AppTheme.leaf, subtitle: '+180 this week'),
                AnimatedMetricCard(title: 'Recycled', value: '${recycled.toStringAsFixed(1)} kg', icon: Icons.recycling, color: AppTheme.ocean, subtitle: 'This month'),
                AnimatedMetricCard(title: 'CO2 reduced', value: '${carbon.toStringAsFixed(0)} kg', icon: Icons.cloud_queue, color: AppTheme.amber, subtitle: 'Estimated'),
                AnimatedMetricCard(title: 'Streak', value: '${user?.streakDays ?? 18} days', icon: Icons.local_fire_department, color: Colors.deepOrange, subtitle: 'Keep it alive'),
              ],
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Quick actions'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing: 10,
              children: [
                QuickActionButton(label: 'Scan', icon: Icons.camera_alt, onTap: () => Navigator.pushNamed(context, AppRoutes.scanner)),
                QuickActionButton(label: 'Pickup', icon: Icons.local_shipping, onTap: () => Navigator.pushNamed(context, AppRoutes.pickup)),
                QuickActionButton(label: 'Guide', icon: Icons.menu_book, onTap: () => Navigator.pushNamed(context, AppRoutes.guide)),
                QuickActionButton(label: 'Centers', icon: Icons.map, onTap: () => Navigator.pushNamed(context, AppRoutes.nearby)),
              ],
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Monthly analytics'),
            SizedBox(
              height: 180,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(leftTitles: AxisTitles(), topTitles: AxisTitles(), rightTitles: AxisTitles()),
                      barGroups: [12, 18, 25, 19, 32, 28].asMap().entries.map((entry) {
                        return BarChartGroupData(x: entry.key, barRods: [BarChartRodData(toY: entry.value.toDouble(), color: Theme.of(context).colorScheme.primary, width: 18, borderRadius: BorderRadius.circular(4))]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Today'),
            Card(
              child: ListTile(
                leading: const Icon(Icons.lightbulb_outline),
                title: const Text('Daily eco tip'),
                subtitle: const Text('Rinse recyclables only when needed and reuse greywater where possible.'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_shipping_outlined),
                title: const Text('Upcoming pickup'),
                subtitle: Text(pickup == null ? 'No pickup scheduled yet' : '${pickup.wasteType} on ${DateFormat('EEE, d MMM h:mm a').format(pickup.scheduledAt)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, AppRoutes.pickup),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.leaderboard_outlined),
                title: const Text('Leaderboard rank'),
                subtitle: const Text('#12 in your ward this week'),
                trailing: FilledButton.tonal(onPressed: () => Navigator.pushNamed(context, AppRoutes.rewards), child: const Text('View')),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.groups_outlined),
                title: const Text('Community feed'),
                subtitle: const Text('Share eco activities, join challenges, and trade local recycling tips.'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, AppRoutes.community),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
