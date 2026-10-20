import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';
import 'module_detail_screen.dart';

class ModuleListScreen extends StatefulWidget {
  const ModuleListScreen({super.key});

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final modules = provider.allModules.where((m) {
      final titleMatch = m.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final descMatch = m.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return titleMatch || descMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Modul TJKT', style: NalarTextStyles.heading2),
        automaticallyImplyLeading: false,
        backgroundColor: NalarColors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Cari modul pembelajaran...',
                  prefixIcon: const Icon(Icons.search_rounded, color: NalarColors.secondaryText),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () => setState(() => _searchQuery = ''),
                        )
                      : null,
                ),
              ),
            ),

            // Module Count Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menampilkan ${modules.length} Modul Pembelajaran',
                    style: NalarTextStyles.caption,
                  ),
                  Text(
                    '${provider.completedModules.length}/12 Selesai',
                    style: NalarTextStyles.caption.copyWith(
                      color: NalarColors.primaryCoral,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Module List
            Expanded(
              child: modules.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 48, color: NalarColors.secondaryText),
                          const SizedBox(height: 12),
                          const Text('Modul tidak ditemukan', style: NalarTextStyles.heading3),
                          const SizedBox(height: 4),
                          const Text('Coba gunakan kata kunci pencarian yang lain.', style: NalarTextStyles.bodySmall),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: modules.length,
                      itemBuilder: (context, index) {
                        final module = modules[index];
                        final isCompleted = provider.isModuleCompleted(module.id);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isCompleted ? NalarColors.success.withOpacity(0.12) : NalarColors.softCoral,
                                    borderRadius: NalarRadius.borderMd,
                                  ),
                                  child: Center(
                                    child: isCompleted
                                        ? const Icon(Icons.check_circle_rounded, color: NalarColors.success, size: 24)
                                        : Text(
                                            '${module.id}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: NalarColors.primaryCoral,
                                            ),
                                          ),
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
                                            child: Text(
                                              module.title,
                                              style: NalarTextStyles.heading3,
                                            ),
                                          ),
                                          if (isCompleted)
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: NalarColors.success.withOpacity(0.12),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Text(
                                                'Selesai',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: NalarColors.success,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        module.description,
                                        style: NalarTextStyles.bodySmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.schedule_rounded, size: 14, color: NalarColors.secondaryText),
                                          const SizedBox(width: 4),
                                          Text(module.estimatedTime, style: NalarTextStyles.caption),
                                          const SizedBox(width: 12),
                                          const Icon(Icons.menu_book_rounded, size: 14, color: NalarColors.secondaryText),
                                          const SizedBox(width: 4),
                                          Text('${module.subChapters.length} Subbab', style: NalarTextStyles.caption),
                                        ],
                                      ),
                                    ],
                                  ),
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
