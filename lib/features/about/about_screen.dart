import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../core/widgets/nalar_logo.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NalarAppBar(title: 'Tentang NALAR'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Logo & Brand Header
              NalarCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const NalarLogo(size: 32, showTagline: true),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: NalarColors.softCoral,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Aplikasi Pembelajaran Digital TJKT SMK',
                        style: TextStyle(
                          color: NalarColors.primaryCoral,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Concept Description
              NalarCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Konsep & Tujuan Aplikasi', style: NalarTextStyles.heading2),
                    const SizedBox(height: 8),
                    const Text(
                      'NALAR merupakan aplikasi pembelajaran digital interaktif yang dirancang khusus untuk membantu siswa kelas X SMK program keahlian Teknologi Jaringan Komputer dan Telekomunikasi (TJKT).\n\n'
                      'Aplikasi ini menyediakan 12 modul materi terstruktur, kuis pemahaman, galeri visual perangkat 3D, simulasi praktikum (Network, PC Assembly, Windows OS), pencatatan absensi, peminjaman alat laboratorium, serta pengelolaan proyek praktikum.',
                      style: NalarTextStyles.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Version Info
              const NalarCard(
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text('Nama Aplikasi'),
                      subtitle: Text('NALAR', style: NalarTextStyles.heading3),
                    ),
                    Divider(height: 1, color: NalarColors.border),
                    ListTile(
                      dense: true,
                      title: Text('Tagline Utama'),
                      subtitle: Text('“Explore Technology. Connect Your Future.”', style: NalarTextStyles.heading3),
                    ),
                    Divider(height: 1, color: NalarColors.border),
                    ListTile(
                      dense: true,
                      title: Text('Target Pengguna'),
                      subtitle: Text('Siswa & Pengajar SMK Program Keahlian TJKT'),
                    ),
                    Divider(height: 1, color: NalarColors.border),
                    ListTile(
                      dense: true,
                      title: Text('Versi Aplikasi'),
                      subtitle: Text('1.0.0 (Release Build)'),
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
}
