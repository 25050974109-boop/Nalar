import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';
import 'quiz_screen.dart';

class ModuleDetailScreen extends StatefulWidget {
  final int moduleId;
  final String? initialSubchapterId;

  const ModuleDetailScreen({
    super.key,
    required this.moduleId,
    this.initialSubchapterId,
  });

  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> {
  late int _activeSubchapterIndex;

  @override
  void initState() {
    super.initState();
    _activeSubchapterIndex = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<AppProvider>(context, listen: false);
    final module = provider.allModules.firstWhere(
      (m) => m.id == widget.moduleId,
      orElse: () => provider.allModules.first,
    );

    if (widget.initialSubchapterId != null) {
      final index = module.subChapters.indexWhere((s) => s.id == widget.initialSubchapterId);
      if (index != -1) {
        _activeSubchapterIndex = index;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final module = provider.allModules.firstWhere(
      (m) => m.id == widget.moduleId,
      orElse: () => provider.allModules.first,
    );

    final currentSubchapter = module.subChapters[_activeSubchapterIndex];
    final isCurrentDone = provider.isSubchapterCompleted(currentSubchapter.id);
    final isModuleDone = provider.isModuleCompleted(module.id);

    // Save last opened module
    provider.setLastOpened(module.id, currentSubchapter.id);

    return Scaffold(
      appBar: NalarAppBar(
        title: 'Modul ${module.id}: ${module.title}',
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Subchapters Horizontal Selector
            Container(
              height: 52,
              color: NalarColors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: module.subChapters.length,
                itemBuilder: (context, index) {
                  final sub = module.subChapters[index];
                  final isSelected = index == _activeSubchapterIndex;
                  final isDone = provider.isSubchapterCompleted(sub.id);

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => setState(() => _activeSubchapterIndex = index),
                      borderRadius: NalarRadius.borderMd,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? NalarColors.primaryCoral
                              : (isDone ? NalarColors.softCoral : NalarColors.white),
                          borderRadius: NalarRadius.borderMd,
                          border: Border.all(
                            color: isSelected ? NalarColors.primaryCoral : NalarColors.border,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (isDone && !isSelected)
                              const Icon(Icons.check_circle_rounded, size: 14, color: NalarColors.success)
                            else if (isDone && isSelected)
                              const Icon(Icons.check_circle_rounded, size: 14, color: NalarColors.white),
                            if (isDone) const SizedBox(width: 4),
                            Text(
                              'Subbab ${index + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? NalarColors.white
                                    : (isDone ? NalarColors.primaryCoral : NalarColors.charcoal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(height: 1, color: NalarColors.border),

            // Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Objective Card
                    NalarCard(
                      backgroundColor: NalarColors.softCoral.withOpacity(0.5),
                      borderColor: NalarColors.brightCoral.withOpacity(0.3),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.track_changes_rounded, color: NalarColors.primaryCoral, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tujuan Pembelajaran:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: NalarColors.primaryCoral,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  module.objective,
                                  style: NalarTextStyles.bodySmall.copyWith(color: NalarColors.charcoal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subchapter Title
                    Text(
                      currentSubchapter.title,
                      style: NalarTextStyles.heading2,
                    ),
                    const SizedBox(height: 12),

                    // Subchapter Content
                    SelectableText(
                      currentSubchapter.content,
                      style: NalarTextStyles.bodyLarge.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 24),

                    // Subchapter Navigation Buttons
                    Row(
                      children: [
                        if (_activeSubchapterIndex > 0)
                          Expanded(
                            child: NalarButton(
                              text: 'Sebelumnya',
                              icon: Icons.arrow_back_rounded,
                              type: NalarButtonType.outlined,
                              onPressed: () {
                                setState(() => _activeSubchapterIndex--);
                              },
                            ),
                          ),
                        if (_activeSubchapterIndex > 0 && _activeSubchapterIndex < module.subChapters.length - 1)
                          const SizedBox(width: 12),
                        if (_activeSubchapterIndex < module.subChapters.length - 1)
                          Expanded(
                            child: NalarButton(
                              text: 'Berikutnya',
                              icon: Icons.arrow_forward_rounded,
                              type: NalarButtonType.primary,
                              onPressed: () {
                                provider.markSubchapterCompleted(module.id, currentSubchapter.id);
                                setState(() => _activeSubchapterIndex++);
                              },
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Mark Finished & Start Quiz Bar
                    NalarCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Status Subbab Ini:', style: NalarTextStyles.heading3),
                              if (isCurrentDone)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: NalarColors.success.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_rounded, size: 14, color: NalarColors.success),
                                      SizedBox(width: 4),
                                      Text(
                                        'Selesai Dibaca',
                                        style: TextStyle(
                                          color: NalarColors.success,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                const Text('Belum Selesai', style: NalarTextStyles.caption),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (!isCurrentDone)
                            NalarButton(
                              text: 'Tandai Subbab Selesai',
                              icon: Icons.check_circle_outline_rounded,
                              type: NalarButtonType.secondary,
                              fullWidth: true,
                              onPressed: () {
                                provider.markSubchapterCompleted(module.id, currentSubchapter.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Subbab berhasil ditandai selesai!'),
                                    backgroundColor: NalarColors.success,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          const SizedBox(height: 12),
                          NalarButton(
                            text: isModuleDone ? 'Kerjakan Ulang Kuis Modul' : 'Mulai Kuis Modul Ini',
                            icon: Icons.quiz_rounded,
                            type: NalarButtonType.primary,
                            fullWidth: true,
                            onPressed: () {
                              provider.markSubchapterCompleted(module.id, currentSubchapter.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => QuizScreen(
                                    moduleId: module.id,
                                    moduleTitle: module.title,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
