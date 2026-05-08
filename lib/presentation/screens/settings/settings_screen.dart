import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/settings_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsViewModel>();
    final dark = settings.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: dark,
            onChanged: settings.toggleTheme,
            title: const Text('Dark mode'),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('English, Hindi, Tamil ready'),
            trailing: DropdownButton<String>(
              value: settings.locale.languageCode,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'hi', child: Text('Hindi')),
                DropdownMenuItem(value: 'ta', child: Text('Tamil')),
              ],
              onChanged: (value) {
                if (value != null) settings.setLanguage(value);
              },
            ),
          ),
          const ListTile(
            leading: Icon(Icons.offline_bolt_outlined),
            title: Text('Offline caching'),
            subtitle: Text('Guide data and user preferences are cached locally.'),
          ),
          const ListTile(
            leading: Icon(Icons.accessibility_new),
            title: Text('Accessibility'),
            subtitle: Text('Material semantics, scalable type, and high contrast surfaces.'),
          ),
          const ListTile(
            leading: Icon(Icons.notifications_active_outlined),
            title: Text('Push notifications'),
            subtitle: Text('Pickup reminders, rewards, challenges, and awareness tips.'),
          ),
        ],
      ),
    );
  }
}
