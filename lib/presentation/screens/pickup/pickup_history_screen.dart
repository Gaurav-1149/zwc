import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/models/pickup_request.dart';
import '../../providers/pickup_view_model.dart';
import '../../widgets/status_chip.dart';

class PickupHistoryScreen extends StatelessWidget {
  const PickupHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pickups = context.watch<PickupViewModel>().pickups;
    return Scaffold(
      appBar: AppBar(title: const Text('Pickup History')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pickups.length,
        itemBuilder: (context, index) {
          final pickup = pickups[index];
          return Card(
            child: ListTile(
              title: Text(pickup.wasteType),
              subtitle: Text('${pickup.address}\n${DateFormat('d MMM yyyy, h:mm a').format(pickup.scheduledAt)}'),
              isThreeLine: true,
              trailing: StatusChip(label: pickup.status.name, color: pickup.status == PickupStatus.completed ? Colors.green : Colors.orange),
            ),
          );
        },
      ),
    );
  }
}
