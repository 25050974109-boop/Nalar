import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/demo/demo_data.dart';
import 'borrowing_form_screen.dart';
import 'borrowing_history_screen.dart';

class BorrowingCatalogScreen extends StatelessWidget {
  const BorrowingCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final equipmentList = DemoData.labEquipment;

    return Scaffold(
      appBar: NalarAppBar(
        title: 'Peminjaman Alat Lab',
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: NalarColors.charcoal),
            tooltip: 'Riwayat Peminjaman',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BorrowingHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Notice
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: NalarColors.softCoral,
              child: const Row(
                children: [
                  Icon(Icons.assignment_outlined, size: 16, color: NalarColors.primaryCoral),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pilih alat laboratorium TJKT untuk mengajukan formulir peminjaman praktikum.',
                      style: TextStyle(fontSize: 11, color: NalarColors.primaryCoral, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            // Equipment Catalog List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  final item = equipmentList[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: NalarCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: NalarColors.softCoral,
                                  borderRadius: NalarRadius.borderMd,
                                ),
                                child: Icon(_getIcon(item.iconName), color: NalarColors.primaryCoral),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name, style: NalarTextStyles.heading3),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Kategori: ${item.category} • Kondisi: ${item.condition}',
                                      style: NalarTextStyles.caption,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: item.isAvailable
                                      ? NalarColors.success.withOpacity(0.12)
                                      : NalarColors.primaryCoral.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item.isAvailable ? 'Tersedia' : 'Dipinjam',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: item.isAvailable ? NalarColors.success : NalarColors.primaryCoral,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(item.description, style: NalarTextStyles.bodySmall),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: item.isAvailable
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BorrowingFormScreen(equipment: item),
                                          ),
                                        );
                                      }
                                    : null,
                                icon: const Icon(Icons.add_task_rounded, size: 16),
                                label: const Text('Ajukan Peminjaman', style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'build':
        return Icons.build_rounded;
      case 'fact_check':
        return Icons.fact_check_rounded;
      case 'router':
        return Icons.router_rounded;
      case 'hub':
        return Icons.hub_rounded;
      case 'wifi':
        return Icons.wifi_rounded;
      case 'cable':
        return Icons.cable_rounded;
      default:
        return Icons.inventory_2_rounded;
    }
  }
}
