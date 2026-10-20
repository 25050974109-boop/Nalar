import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NalarAppBar(title: 'Bantuan & Panduan'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Panduan Penggunaan Aplikasi NALAR',
              style: NalarTextStyles.heading2,
            ),
            const SizedBox(height: 6),
            const Text(
              'Temukan petunjuk penggunaan fitur-fitur pembelajaran TJKT berikut:',
              style: NalarTextStyles.bodySmall,
            ),
            const SizedBox(height: 16),

            _buildHelpItem(
              icon: Icons.menu_book_rounded,
              title: 'Cara Mempelajari Modul & Kuis',
              content: '1. Buka menu "Materi" di navigasi bawah.\n2. Pilih modul TJKT yang ingin dipelajari.\n3. Baca setiap subbab dan tekan "Tandai Subbab Selesai".\n4. Kerjakan kuis di akhir modul untuk menguji pemahaman.',
            ),
            _buildHelpItem(
              icon: Icons.devices_rounded,
              title: 'Cara Menggunakan Simulasi Interaktif',
              content: '1. Buka menu "Simulasi".\n2. Pilih Network Simulator untuk uji ping jaringan, PC Assembly Simulator untuk perakitan PC, atau Windows Simulator untuk navigasi OS.\n3. Ikuti instruksi interaktif pada setiap laboratorium simulasi.',
            ),
            _buildHelpItem(
              icon: Icons.auto_awesome_rounded,
              title: 'Cara Menggunakan Asisten AI',
              content: '1. Buka Asisten AI dari Beranda atau Menu.\n2. Ketikkan pertanyaan seputar TJKT (seperti "Apa itu router?").\n3. Asisten AI akan memberikan penjelasan edukatif dalam Bahasa Indonesia.',
            ),
            _buildHelpItem(
              icon: Icons.inventory_2_rounded,
              title: 'Cara Mengajukan Peminjaman Alat Lab',
              content: '1. Pilih menu "Peminjaman Alat Laboratorium".\n2. Pilih alat yang tersedia lalu tekan "Ajukan Peminjaman".\n3. Isi formulir nama, kelas, tanggal peminjaman & pengembalian.\n4. Pantau status pengajuan di "Riwayat Peminjaman".',
            ),
            _buildHelpItem(
              icon: Icons.insights_rounded,
              title: 'Perhitungan Progres Belajar',
              content: 'Progres dihitung transparan dari:\n- 60% Bobot Penyelesaian 12 Modul\n- 20% Bobot Rata-rata Nilai Kuis\n- 20% Bobot Penyelesaian Project Praktikum.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem({required IconData icon, required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: NalarCard(
        child: ExpansionTile(
          leading: Icon(icon, color: NalarColors.primaryCoral),
          title: Text(title, style: NalarTextStyles.heading3),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(content, style: NalarTextStyles.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
