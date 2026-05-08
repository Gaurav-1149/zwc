import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/waste_guide_view_model.dart';
import '../../widgets/eco_scaffold.dart';

class WasteGuideScreen extends StatelessWidget {
  const WasteGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guide = context.watch<WasteGuideViewModel>();
    return EcoScaffold(
      title: 'Waste Guide',
      currentIndex: 1,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            onChanged: guide.search,
            decoration: const InputDecoration(
              hintText: 'Search plastic, food, battery...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          ...guide.categories.map((category) {
            final color = Color(category.binColorHex);
            return Card(
              child: ExpansionTile(
                leading: CircleAvatar(backgroundColor: color, child: const Icon(Icons.delete_outline, color: Colors.white)),
                title: Text(category.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(category.isRecyclable ? 'Recyclable or recoverable' : 'Special handling needed'),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  Align(alignment: Alignment.centerLeft, child: Text(category.description)),
                  const SizedBox(height: 10),
                  Wrap(spacing: 8, runSpacing: 8, children: category.examples.map((item) => Chip(label: Text(item))).toList()),
                  const SizedBox(height: 10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Disposal instructions'),
                    subtitle: Text(category.instructions),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
