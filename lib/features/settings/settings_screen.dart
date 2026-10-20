import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: const NalarAppBar(title: 'Pengaturan Aplikasi'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Notifikasi & Tampilan', style: NalarTextStyles.heading3),
            const SizedBox(height: 8),
            NalarCard(
              child: SwitchListTile(
                activeTrackColor: NalarColors.primaryCoral,
                title: const Text('Notifikasi Aktivitas Lokal', style: NalarTextStyles.heading3),
                subtitle: const Text('Terima pemberitahuan streak dan progres kuis', style: NalarTextStyles.bodySmall),
                value: provider.notificationsEnabled,
                onChanged: (val) => provider.toggleNotificationsEnabled(val),
              ),
            ),
            const SizedBox(height: 20),

            Text('Manajemen Data', style: NalarTextStyles.heading3),
            const SizedBox(height: 8),
            NalarCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.restart_alt_rounded, color: NalarColors.warning),
                    title: const Text('Reset Progres Belajar', style: NalarTextStyles.heading3),
                    subtitle: const Text('Mengosongkan capaian modul dan hasil kuis', style: NalarTextStyles.bodySmall),
                    onTap: () => _confirmResetProgress(context, provider),
                  ),
                  const Divider(height: 1, color: NalarColors.border),
                  ListTile(
                    leading: const Icon(Icons.delete_forever_rounded, color: NalarColors.primaryCoral),
                    title: const Text('Hapus Semua Data Demo', style: NalarTextStyles.heading3),
                    subtitle: const Text('Menghapus riwayat absensi, peminjaman, & profil', style: NalarTextStyles.bodySmall),
                    onTap: () => _confirmClearAllData(context, provider),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Informasi Versi', style: NalarTextStyles.heading3),
            const SizedBox(height: 8),
            const NalarCard(
              child: ListTile(
                leading: Icon(Icons.info_rounded, color: NalarColors.primaryCoral),
                title: Text('NALAR App', style: NalarTextStyles.heading3),
                subtitle: Text('Versi 1.0.0 (Build 1) • Explore Technology. Connect Your Future.'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmResetProgress(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progres Belajar?'),
        content: const Text('Seluruh riwayat penyelesaian modul dan nilai kuis akan dikosongkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: NalarColors.primaryCoral),
            onPressed: () async {
              Navigator.pop(ctx);
              await provider.resetLearningData();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Progres belajar telah direset.')),
                );
              }
            },
            child: const Text('Reset Progres'),
          ),
        ],
      ),
    );
  }

  void _confirmClearAllData(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Semua Data?'),
        content: const Text('Tindakan ini akan mengembalikan seluruh aplikasi ke kondisi awal.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: NalarColors.primaryCoral),
            onPressed: () async {
              Navigator.pop(ctx);
              await provider.clearAllData();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Seluruh data demo aplikasi berhasil dibersihkan.')),
                );
              }
            },
            child: const Text('Hapus Semua'),
          ),
        ],
      ),
    );
  }
}
