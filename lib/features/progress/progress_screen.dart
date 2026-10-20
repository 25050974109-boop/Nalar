import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final overallProgress = provider.overallProgressPercentage;
    final badges = provider.achievementBadges;

    return Scaffold(
      appBar: const NalarAppBar(title: 'Progres Belajar Siswa'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overall Circular Chart Card
              NalarCard(
                padding: const EdgeInsets.all(20),
                backgroundColor: NalarColors.softCoral,
                borderColor: NalarColors.brightCoral.withOpacity(0.3),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            value: overallProgress / 100.0,
                            strokeWidth: 8,
                            backgroundColor: NalarColors.white,
                            valueColor: const AlwaysStoppedAnimation<Color>(NalarColors.primaryCoral),
                          ),
                        ),
                        Text(
                          '${overallProgress.round()}%',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: NalarColors.primaryCoral,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Progres Belajar', style: NalarTextStyles.heading2),
                          const SizedBox(height: 4),
                          Text(
                            'Dihitung secara transparan dari penyelesaian 12 modul, kuis, dan project praktikum.',
                            style: NalarTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Detail Metrics Grid
              Text('Rincian Aktivitas', style: NalarTextStyles.heading2),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Modul Selesai',
                      value: '${provider.completedModules.length} / 12',
                      icon: Icons.menu_book_rounded,
                      color: NalarColors.primaryCoral,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Rata-Rata Kuis',
                      value: '${provider.averageQuizScore}%',
                      icon: Icons.quiz_rounded,
                      color: NalarColors.primaryCoral,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Streak Belajar',
                      value: '${provider.streakDays} Hari',
                      icon: Icons.local_fire_department_rounded,
                      color: NalarColors.warning,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Total Jam',
                      value: '${provider.learningHours.toStringAsFixed(1)} Jam',
                      icon: Icons.access_time_rounded,
                      color: NalarColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Achievement Badges Section
              Text('Lencana Pencapaian', style: NalarTextStyles.heading2),
              const SizedBox(height: 10),

              ...badges.map((badge) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: NalarCard(
                    backgroundColor: badge.isUnlocked ? NalarColors.white : NalarColors.background,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: badge.isUnlocked
                                ? NalarColors.warning.withOpacity(0.15)
                                : NalarColors.border,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getBadgeIcon(badge.iconName),
                            color: badge.isUnlocked ? NalarColors.warning : NalarColors.secondaryText,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(badge.title, style: NalarTextStyles.heading3),
                                  ),
                                  if (badge.isUnlocked)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: NalarColors.success.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Terbuka',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: NalarColors.success),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(badge.description, style: NalarTextStyles.bodySmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return NalarCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 6),
              Text(title, style: NalarTextStyles.caption),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: NalarTextStyles.heading1.copyWith(fontSize: 20, color: NalarColors.charcoal),
          ),
        ],
      ),
    );
  }

  IconData _getBadgeIcon(String iconName) {
    switch (iconName) {
      case 'school':
        return Icons.school_rounded;
      case 'task_alt':
        return Icons.task_alt_rounded;
      case 'stars':
        return Icons.stars_rounded;
      case 'local_fire_department':
        return Icons.local_fire_department_rounded;
      case 'construction':
        return Icons.construction_rounded;
      default:
        return Icons.emoji_events_rounded;
    }
  }
}
