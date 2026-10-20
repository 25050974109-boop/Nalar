import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/models/device_model.dart';

class DeviceDetailScreen extends StatelessWidget {
  final DeviceItem device;

  const DeviceDetailScreen({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NalarAppBar(title: device.name),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visual Display Card
              NalarCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: NalarColors.softCoral,
                        borderRadius: NalarRadius.borderLg,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getDeviceIcon(device.iconName),
                            size: 72,
                            color: NalarColors.primaryCoral,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: NalarColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: NalarColors.border),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.view_in_ar_rounded, size: 14, color: NalarColors.primaryCoral),
                                SizedBox(width: 4),
                                Text(
                                  'Visual Perangkat 3D/2D',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: NalarColors.primaryCoral,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(device.name, style: NalarTextStyles.heading1, textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    Chip(
                      label: Text(device.category.label),
                      backgroundColor: NalarColors.softCoral,
                      labelStyle: const TextStyle(
                        color: NalarColors.primaryCoral,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      side: BorderSide.none,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text('Deskripsi Perangkat', style: NalarTextStyles.heading2),
              const SizedBox(height: 6),
              NalarCard(
                child: Text(
                  device.description,
                  style: NalarTextStyles.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),

              // Function
              Text('Fungsi Utama dalam TJKT', style: NalarTextStyles.heading2),
              const SizedBox(height: 6),
              NalarCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.stars_rounded, color: NalarColors.primaryCoral, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        device.functionText,
                        style: NalarTextStyles.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Example Usage
              Text('Contoh Penggunaan Nyata', style: NalarTextStyles.heading2),
              const SizedBox(height: 6),
              NalarCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.tungsten_rounded, color: NalarColors.warning, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        device.exampleUsage,
                        style: NalarTextStyles.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getDeviceIcon(String iconName) {
    switch (iconName) {
      case 'router':
        return Icons.router_rounded;
      case 'hub':
        return Icons.hub_rounded;
      case 'cable':
        return Icons.cable_rounded;
      case 'developer_board':
        return Icons.developer_board_rounded;
      case 'memory':
        return Icons.memory_rounded;
      case 'wifi':
        return Icons.wifi_rounded;
      case 'sd_card':
        return Icons.sd_card_rounded;
      case 'storage':
        return Icons.storage_rounded;
      default:
        return Icons.devices_rounded;
    }
  }
}
