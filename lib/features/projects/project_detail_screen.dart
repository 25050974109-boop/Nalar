import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);
    final project = provider.projects.firstWhere((p) => p.id == widget.projectId);
    _notesController = TextEditingController(text: project.studentNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final project = provider.projects.firstWhere((p) => p.id == widget.projectId);

    return Scaffold(
      appBar: NalarAppBar(title: project.title),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              NalarCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.title, style: NalarTextStyles.heading2),
                    const SizedBox(height: 6),
                    Text(project.description, style: NalarTextStyles.bodyMedium),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Target Penyelesaian:', style: NalarTextStyles.caption),
                        Text(project.targetDate, style: NalarTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: project.progressPercentage / 100.0,
                        backgroundColor: NalarColors.border,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          project.isCompleted ? NalarColors.success : NalarColors.primaryCoral,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Objective Card
              NalarCard(
                backgroundColor: NalarColors.softCoral.withOpacity(0.5),
                borderColor: NalarColors.brightCoral.withOpacity(0.3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.track_changes_rounded, color: NalarColors.primaryCoral, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tujuan Proyek:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: NalarColors.primaryCoral)),
                          const SizedBox(height: 2),
                          Text(project.objective, style: NalarTextStyles.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Checklist Section
              Text('Checklist Langkah Pengerjaan', style: NalarTextStyles.heading2),
              const SizedBox(height: 10),

              ...project.checklist.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: NalarCard(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: CheckboxListTile(
                      value: item.isCompleted,
                      activeColor: NalarColors.primaryCoral,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.taskName,
                        style: NalarTextStyles.bodyMedium.copyWith(
                          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                          color: item.isCompleted ? NalarColors.secondaryText : NalarColors.charcoal,
                        ),
                      ),
                      onChanged: (_) {
                        provider.toggleProjectChecklist(project.id, item.id);
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Student Notes Section
              Text('Catatan Praktikum Siswa', style: NalarTextStyles.heading2),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan catatan hasil praktikum, temuan kendala, atau IP address yang digunakan...',
                ),
              ),
              const SizedBox(height: 12),
              NalarButton(
                text: 'Simpan Catatan & Progres',
                icon: Icons.save_rounded,
                fullWidth: true,
                onPressed: () {
                  provider.updateProjectNotes(project.id, _notesController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Catatan praktikum berhasil disimpan!'),
                      backgroundColor: NalarColors.success,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
