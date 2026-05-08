import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/scanner_view_model.dart';
import '../../widgets/eco_scaffold.dart';
import '../../widgets/loading_overlay.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanner = context.watch<ScannerViewModel>();
    return EcoScaffold(
      title: 'AI Waste Scanner',
      currentIndex: 2,
      child: LoadingOverlay(
        isLoading: scanner.isLoading,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.45),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.center_focus_strong, size: 96),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      final file = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (file != null && context.mounted) context.read<ScannerViewModel>().classifyImage(file.path);
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Camera'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (file != null && context.mounted) context.read<ScannerViewModel>().classifyImage(file.path);
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload'),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: scanner.scanDemo,
              icon: const Icon(Icons.psychology_alt_outlined),
              label: const Text('Run mock TensorFlow Lite classifier'),
            ),
            if (scanner.result != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(scanner.result!.wasteType, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: scanner.result!.confidence),
                      const SizedBox(height: 8),
                      Text('Confidence ${(scanner.result!.confidence * 100).round()}%'),
                      const Divider(height: 28),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(scanner.result!.recyclable ? Icons.check_circle : Icons.warning_amber),
                        title: Text(scanner.result!.recyclable ? 'Recycling possible' : 'Special handling required'),
                        subtitle: Text(scanner.result!.instructions),
                      ),
                      Chip(label: Text('+${scanner.result!.points} eco points')),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
