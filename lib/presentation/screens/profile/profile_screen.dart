import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../providers/auth_view_model.dart';
import '../../widgets/eco_scaffold.dart';
import '../../widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final user = auth.user;
    return EcoScaffold(
      title: 'Profile',
      currentIndex: 4,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(radius: 42, child: Text((user?.name.isNotEmpty ?? false) ? user!.name.substring(0, 1) : 'E')),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.name ?? 'Eco Citizen', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                    Text(user?.email ?? ''),
                    Text(user?.phone ?? ''),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Impact'),
          Card(
            child: Column(
              children: [
                ListTile(leading: const Icon(Icons.eco), title: const Text('Eco points'), trailing: Text('${user?.ecoPoints ?? 0}')),
                ListTile(leading: const Icon(Icons.recycling), title: const Text('Waste recycled'), trailing: Text('${user?.wasteRecycledKg ?? 0} kg')),
                ListTile(leading: const Icon(Icons.local_fire_department), title: const Text('Streak days'), trailing: Text('${user?.streakDays ?? 0}')),
              ],
            ),
          ),
          const SectionHeader(title: 'Verification and smart features'),
          Card(
            child: Column(
              children: [
                ListTile(leading: const Icon(Icons.qr_code_scanner), title: const Text('QR waste verification'), subtitle: const Text('Scan collector QR to verify handover.'), onTap: () {}),
                ListTile(leading: const Icon(Icons.document_scanner_outlined), title: const Text('Barcode product scanner'), subtitle: const Text('Check package recyclability before purchase.'), onTap: () {}),
                ListTile(leading: const Icon(Icons.smart_toy_outlined), title: const Text('Recycling help chatbot'), subtitle: const Text('Ask disposal questions with a future AI assistant.'), onTap: () => _showChatbot(context)),
                ListTile(leading: const Icon(Icons.sensors_outlined), title: const Text('Smart bin IoT placeholder'), subtitle: const Text('Connect fill-level sensors in future releases.'), onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () async {
              await auth.logout();
              if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showChatbot(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recycling helper', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            const Text('Demo answer: Pizza boxes with oil stains go to compost or wet waste. Clean cardboard lids can go to dry recycling.'),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(hintText: 'Ask about an item...')),
          ],
        ),
      ),
    );
  }
}
