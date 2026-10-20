import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';
import 'project_detail_screen.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final projects = provider.projects;

    return Scaffold(
      appBar: const NalarAppBar(title: 'Proyek Praktikum TJKT'),
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
                      'Pencatatan tugas & proyek praktikum mandiri siswa.',
                      style: TextStyle(fontSize: 11, color: NalarColors.primaryCoral, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            // Project List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  final progress = project.progressPercentage;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: NalarCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProjectDetailScreen(projectId: project.id),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(project.title, style: NalarTextStyles.heading3),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: project.isCompleted
                                      ? NalarColors.success.withOpacity(0.12)
                                      : NalarColors.softCoral,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  project.isCompleted ? 'Selesai' : '${progress.round()}%',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: project.isCompleted ? NalarColors.success : NalarColors.primaryCoral,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(project.description, style: NalarTextStyles.bodySmall),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress / 100.0,
                              backgroundColor: NalarColors.border,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                project.isCompleted ? NalarColors.success : NalarColors.primaryCoral,
                              ),
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Target: ${project.targetDate}',
                                style: NalarTextStyles.caption,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'Buka Detail',
                                    style: TextStyle(
                                      color: NalarColors.primaryCoral,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.chevron_right_rounded, size: 16, color: NalarColors.primaryCoral),
                                ],
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
}
