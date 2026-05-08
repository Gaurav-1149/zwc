import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/pickup_request.dart';
import '../../providers/auth_view_model.dart';
import '../../providers/pickup_view_model.dart';
import '../../widgets/eco_scaffold.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/status_chip.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _address = TextEditingController();
  final _notes = TextEditingController();
  String _wasteType = 'Plastic';
  DateTime _scheduledAt = DateTime.now().add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().user;
    _address.text = user?.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final pickups = context.watch<PickupViewModel>();
    return EcoScaffold(
      title: 'Pickup Booking',
      actions: [
        IconButton(
          tooltip: 'Pickup history',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.pickupHistory),
          icon: const Icon(Icons.history),
        ),
      ],
      child: LoadingOverlay(
        isLoading: pickups.isLoading,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(target: LatLng(12.9784, 77.6408), zoom: 13),
                  markers: const {
                    Marker(markerId: MarkerId('collector'), position: LatLng(12.9784, 77.6408), infoWindow: InfoWindow(title: 'Assigned collector')),
                  },
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _wasteType,
                    decoration: const InputDecoration(labelText: 'Waste type'),
                    items: const ['Wet Waste', 'Dry Waste', 'Plastic', 'E-Waste', 'Medical Waste', 'Hazardous Waste']
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) => setState(() => _wasteType = value ?? _wasteType),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(controller: _address, validator: (v) => Validators.required(v, 'Address'), maxLines: 2, decoration: const InputDecoration(labelText: 'Pickup address')),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.event),
                    title: Text(DateFormat('EEE, d MMM yyyy').format(_scheduledAt)),
                    subtitle: Text(DateFormat('h:mm a').format(_scheduledAt)),
                    trailing: const Icon(Icons.edit_calendar),
                    onTap: _chooseDateTime,
                  ),
                  TextFormField(controller: _notes, maxLines: 2, decoration: const InputDecoration(labelText: 'Notes for collector')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                await context.read<PickupViewModel>().schedule(_wasteType, _address.text, _scheduledAt, _notes.text);
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pickup scheduled')));
              },
              icon: const Icon(Icons.local_shipping),
              label: const Text('Schedule pickup'),
            ),
            const SizedBox(height: 20),
            Text('Track status', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            if (pickups.upcoming != null) _PickupTile(pickup: pickups.upcoming!) else const Text('No upcoming pickup.'),
          ],
        ),
      ),
    );
  }

  Future<void> _chooseDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_scheduledAt));
    if (time == null) return;
    setState(() => _scheduledAt = DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }
}

class _PickupTile extends StatelessWidget {
  const _PickupTile({required this.pickup});

  final PickupRequest pickup;

  @override
  Widget build(BuildContext context) {
    final colors = {
      PickupStatus.pending: Colors.orange,
      PickupStatus.accepted: Colors.blue,
      PickupStatus.inTransit: Colors.purple,
      PickupStatus.completed: Colors.green,
    };
    return Card(
      child: ListTile(
        leading: const Icon(Icons.recycling),
        title: Text(pickup.wasteType),
        subtitle: Text(DateFormat('EEE, d MMM h:mm a').format(pickup.scheduledAt)),
        trailing: StatusChip(label: pickup.status.name, color: colors[pickup.status]!),
      ),
    );
  }
}
