import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/demo/demo_data.dart';
import '../../data/models/device_model.dart';
import 'device_detail_screen.dart';

class DeviceGalleryScreen extends StatefulWidget {
  const DeviceGalleryScreen({super.key});

  @override
  State<DeviceGalleryScreen> createState() => _DeviceGalleryScreenState();
}

class _DeviceGalleryScreenState extends State<DeviceGalleryScreen> {
  DeviceCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final devices = DemoData.devices.where((device) {
      final categoryMatch = _selectedCategory == null || device.category == _selectedCategory;
      final queryMatch = device.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          device.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return categoryMatch && queryMatch;
    }).toList();

    return Scaffold(
      appBar: const NalarAppBar(title: 'Galeri Perangkat TJKT'),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Cari perangkat (Router, UTP, RAM)...',
                  prefixIcon: const Icon(Icons.search_rounded, color: NalarColors.secondaryText),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () => setState(() => _searchQuery = ''),
                        )
                      : null,
                ),
              ),
            ),

            // Category Tabs
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryChip('Semua', null),
                  ...DeviceCategory.values.map(
                    (cat) => _buildCategoryChip(cat.label, cat),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Device Grid / List
            Expanded(
              child: devices.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.devices_other_rounded, size: 48, color: NalarColors.secondaryText),
                          const SizedBox(height: 12),
                          const Text('Perangkat tidak ditemukan', style: NalarTextStyles.heading3),
                          const SizedBox(height: 4),
                          const Text('Coba pilih kategori atau pencarian lain.', style: NalarTextStyles.bodySmall),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.82,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        final device = devices[index];
                        return NalarCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DeviceDetailScreen(device: device),
                              ),
                            );
                          },
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: NalarColors.softCoral,
                                  borderRadius: NalarRadius.borderMd,
                                ),
                                child: Center(
                                  child: Icon(
                                    _getDeviceIcon(device.iconName),
                                    size: 36,
                                    color: NalarColors.primaryCoral,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: NalarColors.background,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  device.category.label,
                                  style: NalarTextStyles.caption.copyWith(fontSize: 10),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                device.name,
                                style: NalarTextStyles.heading3.copyWith(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Expanded(
                                child: Text(
                                  device.description,
                                  style: NalarTextStyles.bodySmall.copyWith(fontSize: 11),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, DeviceCategory? category) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() => _selectedCategory = category);
          }
        },
        selectedColor: NalarColors.primaryCoral,
        backgroundColor: NalarColors.white,
        labelStyle: TextStyle(
          color: isSelected ? NalarColors.white : NalarColors.charcoal,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: NalarRadius.borderMd,
          side: BorderSide(
            color: isSelected ? NalarColors.primaryCoral : NalarColors.border,
          ),
        ),
        showCheckmark: false,
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
