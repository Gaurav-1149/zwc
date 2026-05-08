import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/dummy/dummy_data.dart';

class NearbyCentersScreen extends StatelessWidget {
  const NearbyCentersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final markers = DummyData.centers
        .map((center) => Marker(
              markerId: MarkerId(center.id),
              position: LatLng(center.latitude, center.longitude),
              infoWindow: InfoWindow(title: center.name, snippet: center.type),
            ))
        .toSet();
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Recycling Centers')),
      body: Column(
        children: [
          SizedBox(
            height: 260,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 12),
              markers: markers,
              myLocationButtonEnabled: true,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: DummyData.centers.length,
              itemBuilder: (context, index) {
                final center = DummyData.centers[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(center.name),
                    subtitle: Text('${center.type}\n${center.address}\n${center.distanceKm} km away · ${center.rating} rating · ${center.phone}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      tooltip: 'Directions',
                      onPressed: () {},
                      icon: const Icon(Icons.directions_outlined),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
