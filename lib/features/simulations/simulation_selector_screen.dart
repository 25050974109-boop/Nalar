import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_card.dart';
import 'network_simulator_screen.dart';
import 'pc_assembly_simulator_screen.dart';
import 'windows_simulator_screen.dart';

class SimulationSelectorScreen extends StatelessWidget {
  const SimulationSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi Pembelajaran TJKT', style: NalarTextStyles.heading2),
        automaticallyImplyLeading: false,
        backgroundColor: NalarColors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih laboratorium simulasi praktiktik interaktif untuk melatih pemahaman kamu:',
                style: NalarTextStyles.bodySmall,
              ),
              const SizedBox(height: 16),

              // 1. Network Simulator Card
              _buildSimCard(
                context,
                title: 'Network Simulator',
                category: 'Simulasi Jaringan Komputer',
                description: 'Rancang topologi jaringan, sambungkan Router, Switch & PC, serta simulasikan pengiriman paket data secara visual.',
                icon: Icons.alt_route_rounded,
                badgeText: 'Topologi & Ping',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NetworkSimulatorScreen()),
                  );
                },
              ),
              const SizedBox(height: 14),

              // 2. PC Assembly Simulator Card
              _buildSimCard(
                context,
                title: 'PC Assembly Simulator',
                category: 'Simulasi Perakitan Komputer',
                description: 'Pelajari komponen utama PC dan ikuti langkah demi langkah merakit motherboard, CPU, RAM, SSD, dan power supply.',
                icon: Icons.developer_board_rounded,
                badgeText: 'Perakitan Hardware',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PcAssemblySimulatorScreen()),
                  );
                },
              ),
              const SizedBox(height: 14),

              // 3. Windows Simulator Card
              _buildSimCard(
                context,
                title: 'Windows Simulator',
                category: 'Simulasi Sistem Operasi',
                description: 'Eksplorasi antarmuka Sistem Operasi Windows, manajemen file di File Explorer, Start Menu, dan Command Prompt.',
                icon: Icons.desktop_windows_rounded,
                badgeText: 'OS & File System',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WindowsSimulatorScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimCard(
    BuildContext context, {
    required String title,
    required String category,
    required String description,
    required IconData icon,
    required String badgeText,
    required VoidCallback onTap,
  }) {
    return NalarCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: NalarColors.softCoral,
                  borderRadius: NalarRadius.borderMd,
                ),
                child: Icon(icon, color: NalarColors.primaryCoral, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: NalarColors.primaryCoral.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: NalarColors.primaryCoral,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(title, style: NalarTextStyles.heading2.copyWith(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: NalarTextStyles.bodyMedium),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text(badgeText),
                backgroundColor: NalarColors.background,
                labelStyle: NalarTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                side: BorderSide.none,
              ),
              const Row(
                children: [
                  Text(
                    'Mulai Simulasi',
                    style: TextStyle(
                      color: NalarColors.primaryCoral,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded, size: 16, color: NalarColors.primaryCoral),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
