import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';
import '../profile/profile_screen.dart';
import '../progress/progress_screen.dart';
import '../device_gallery/device_gallery_screen.dart';
import '../ai_assistant/ai_assistant_screen.dart';
import '../attendance/attendance_screen.dart';
import '../borrowing/borrowing_catalog_screen.dart';
import '../projects/project_list_screen.dart';
import '../settings/settings_screen.dart';
import '../help/help_screen.dart';
import '../about/about_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final profile = provider.profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Fitur NALAR', style: NalarTextStyles.heading2),
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
              // User Profile Banner Card
              NalarCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: NalarColors.primaryCoral,
                      child: Text(
                        profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'S',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: NalarColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.name, style: NalarTextStyles.heading2.copyWith(fontSize: 16)),
                          const SizedBox(height: 2),
                          Text('${profile.studentClass} • ${profile.email}', style: NalarTextStyles.caption),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: NalarColors.secondaryText),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text('Fitur Utama & Pendukung', style: NalarTextStyles.heading3),
              const SizedBox(height: 10),

              _buildMenuItem(
                context,
                title: 'Profil Saya',
                subtitle: 'Lihat dan ubah data profil lokal',
                icon: Icons.person_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Progres Belajar & Lencana',
                subtitle: 'Statistik capaian modul, kuis, & badges',
                icon: Icons.insights_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Galeri Perangkat 3D',
                subtitle: 'Visualisasi router, switch, kabel, & hardware',
                icon: Icons.devices_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeviceGalleryScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Video Pembelajaran TJKT',
                subtitle: 'Tutorial YouTube pengkabelan, subnetting, & MikroTik',
                icon: Icons.ondemand_video_rounded,
                onTap: () => provider.setBottomNavIndex(3),
              ),
              _buildMenuItem(
                context,
                title: 'Asisten AI NALAR',
                subtitle: 'Tanya jawab seputar materi TJKT',
                icon: Icons.auto_awesome_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AIAssistantScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Absensi Siswa',
                subtitle: 'Pencatatan harian kehadiran mandiri',
                icon: Icons.fact_check_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Peminjaman Alat Laboratorium',
                subtitle: 'Katalog & pengajuan peminjaman alat lab',
                icon: Icons.inventory_2_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BorrowingCatalogScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Proyek Praktikum TJKT',
                subtitle: 'Daftar tugas & checklist praktikum',
                icon: Icons.assignment_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProjectListScreen())),
              ),

              const SizedBox(height: 16),
              Text('Sistem & Bantuan', style: NalarTextStyles.heading3),
              const SizedBox(height: 10),

              _buildMenuItem(
                context,
                title: 'Pengaturan App',
                subtitle: 'Notifikasi, reset progres, & data',
                icon: Icons.settings_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Bantuan & Panduan',
                subtitle: 'Cara menggunakan aplikasi NALAR',
                icon: Icons.help_outline_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpScreen())),
              ),
              _buildMenuItem(
                context,
                title: 'Tentang NALAR',
                subtitle: 'Versi aplikasi, tagline, & identitas',
                icon: Icons.info_outline_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: NalarCard(
        onTap: onTap,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: NalarColors.softCoral,
                borderRadius: NalarRadius.borderMd,
              ),
              child: Icon(icon, color: NalarColors.primaryCoral, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: NalarTextStyles.heading3.copyWith(fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: NalarTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: NalarColors.secondaryText, size: 20),
          ],
        ),
      ),
    );
  }
}
