import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isCheckedIn = provider.isCheckedInToday;
    final checkIns = provider.checkIns;

    final now = DateTime.now();
    final dateFormatted = '${now.day} ${_getMonthName(now.month)} ${now.year}';

    return Scaffold(
      appBar: const NalarAppBar(title: 'Absensi Siswa'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notice banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: NalarColors.softCoral,
                  borderRadius: NalarRadius.borderMd,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: NalarColors.primaryCoral, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Pencatatan absensi pada versi lokal NALAR merupakan catatan mandiri kegiatan belajar siswa.',
                        style: TextStyle(fontSize: 11, color: NalarColors.primaryCoral),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Today's Status Card
              NalarCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 40, color: NalarColors.primaryCoral),
                    const SizedBox(height: 8),
                    Text(dateFormatted, style: NalarTextStyles.heading2),
                    const SizedBox(height: 4),
                    Text(
                      isCheckedIn ? 'Status Hari Ini: Hadir' : 'Status Hari Ini: Belum Check-In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCheckedIn ? NalarColors.success : NalarColors.primaryCoral,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    NalarButton(
                      text: isCheckedIn ? 'Sudah Check-In Hari Ini' : 'Check-In Kehadiran',
                      icon: isCheckedIn ? Icons.check_circle_rounded : Icons.touch_app_rounded,
                      type: isCheckedIn ? NalarButtonType.secondary : NalarButtonType.primary,
                      fullWidth: true,
                      onPressed: isCheckedIn ? null : () => _confirmCheckIn(context, provider),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Check-In History
              Text('Riwayat Absensi Mandiri', style: NalarTextStyles.heading2),
              const SizedBox(height: 10),

              if (checkIns.isEmpty)
                const NalarCard(
                  child: Center(
                    child: Text('Belum ada riwayat absensi.', style: NalarTextStyles.bodySmall),
                  ),
                )
              else
                ...checkIns.map((item) {
                  final formattedItemDate = '${item.date.day} ${_getMonthName(item.date.month)} ${item.date.year}';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: NalarCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: NalarColors.success.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_rounded, color: NalarColors.success, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(formattedItemDate, style: NalarTextStyles.heading3),
                                  const SizedBox(height: 2),
                                  Text('Waktu: ${item.timeString}', style: NalarTextStyles.caption),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: NalarColors.success.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item.status,
                              style: const TextStyle(
                                color: NalarColors.success,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmCheckIn(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Check-In'),
        content: const Text('Apakah kamu yakin ingin mencatat kehadiran kegiatan belajar hari ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              bool success = await provider.checkInToday();
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Check-In berhasil dicatat!'),
                    backgroundColor: NalarColors.success,
                  ),
                );
              }
            },
            child: const Text('Check-In'),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }
}
