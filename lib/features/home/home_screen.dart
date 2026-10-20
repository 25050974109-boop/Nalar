import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/theme/nalar_spacing.dart';
import '../../core/widgets/nalar_logo.dart';
import '../../core/widgets/nalar_card.dart';
import '../../core/widgets/nalar_button.dart';
import '../../providers/app_provider.dart';
import '../learning/module_detail_screen.dart';
import '../progress/progress_screen.dart';
import '../ai_assistant/ai_assistant_screen.dart';
import '../notifications/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final profile = provider.profile;
    final lastModuleId = provider.lastOpenedModuleId;
    final lastSubchapterId = provider.lastOpenedSubchapterId;
    final lastModule = provider.allModules.firstWhere(
      (m) => m.id == lastModuleId,
      orElse: () => provider.allModules.first,
    );

    return Scaffold(
      backgroundColor: NalarColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const NalarLogo(size: 20),
                        const SizedBox(height: 6),
                        Text(
                          'Halo, ${profile.name.split(' ').first}! 👋',
                          style: NalarTextStyles.heading1,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Siap melanjutkan pembelajaran TJKT hari ini?',
                          style: NalarTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.notifications_outlined, size: 28),
                        color: NalarColors.charcoal,
                      ),
                      if (provider.unreadNotificationCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: NalarColors.primaryCoral,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${provider.unreadNotificationCount}',
                              style: const TextStyle(
                                color: NalarColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: NalarSpacing.md),

              // Progress Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NalarColors.primaryCoral, NalarColors.brightCoral],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: NalarRadius.borderXl,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33FF5B4D),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ringkasan Progres Belajar',
                          style: TextStyle(
                            color: NalarColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${provider.overallProgressPercentage.round()}% Selesai',
                            style: const TextStyle(
                              color: NalarColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: provider.overallProgressPercentage / 100.0,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(NalarColors.white),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMetricTile(
                          icon: Icons.menu_book_rounded,
                          value: '${provider.completedModules.length}/12',
                          label: 'Modul Selesai',
                        ),
                        Container(height: 30, width: 1, color: Colors.white30),
                        _buildMetricTile(
                          icon: Icons.access_time_rounded,
                          value: '${provider.learningHours.toStringAsFixed(1)} Jam',
                          label: 'Waktu Belajar',
                        ),
                        Container(height: 30, width: 1, color: Colors.white30),
                        _buildMetricTile(
                          icon: Icons.local_fire_department_rounded,
                          value: '${provider.streakDays} Hari',
                          label: 'Streak Belajar',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: NalarSpacing.md),

              // Continue Learning Card
              Text('Lanjutkan Belajar', style: NalarTextStyles.heading3),
              const SizedBox(height: 8),
              NalarCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: NalarColors.softCoral,
                            borderRadius: NalarRadius.borderMd,
                          ),
                          child: const Icon(
                            Icons.play_circle_fill_rounded,
                            color: NalarColors.primaryCoral,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Modul ${lastModule.id}: ${lastModule.title}',
                                style: NalarTextStyles.heading3,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lastModule.description,
                                style: NalarTextStyles.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    NalarButton(
                      text: 'Lanjutkan Belajar',
                      icon: Icons.arrow_forward_rounded,
                      fullWidth: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ModuleDetailScreen(
                              moduleId: lastModule.id,
                              initialSubchapterId: lastSubchapterId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: NalarSpacing.md),

              // Quick Access Shortcuts
              Text('Akses Cepat', style: NalarTextStyles.heading3),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickCard(
                      title: 'Modul Materi',
                      subtitle: '12 Modul TJKT',
                      icon: Icons.menu_book_rounded,
                      onTap: () => provider.setBottomNavIndex(1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickCard(
                      title: 'Simulasi',
                      subtitle: 'Praktik Interaktif',
                      icon: Icons.devices_rounded,
                      onTap: () => provider.setBottomNavIndex(2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickCard(
                      title: 'Lihat Progres',
                      subtitle: 'Statistik & Lencana',
                      icon: Icons.insights_rounded,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgressScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickCard(
                      title: 'Asisten AI',
                      subtitle: 'Tanya Jawab TJKT',
                      icon: Icons.auto_awesome_rounded,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AIAssistantScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: NalarSpacing.md),

              // Recommended Modules
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rekomendasi Materi', style: NalarTextStyles.heading3),
                  TextButton(
                    onPressed: () => provider.setBottomNavIndex(1),
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(color: NalarColors.primaryCoral, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ...provider.allModules
                  .where((m) => !provider.isModuleCompleted(m.id))
                  .take(3)
                  .map((module) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: NalarCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ModuleDetailScreen(moduleId: module.id),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: NalarColors.softCoral,
                                  borderRadius: NalarRadius.borderMd,
                                ),
                                child: Center(
                                  child: Text(
                                    '${module.id}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: NalarColors.primaryCoral,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(module.title, style: NalarTextStyles.heading3),
                                    const SizedBox(height: 2),
                                    Text(
                                      module.description,
                                      style: NalarTextStyles.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right_rounded, color: NalarColors.secondaryText),
                            ],
                          ),
                        ),
                      )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricTile({required IconData icon, required String value, required String label}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: NalarColors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                color: NalarColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return NalarCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: NalarColors.softCoral,
              borderRadius: NalarRadius.borderMd,
            ),
            child: Icon(icon, color: NalarColors.primaryCoral, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: NalarTextStyles.heading3.copyWith(fontSize: 13)),
                Text(subtitle, style: NalarTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
