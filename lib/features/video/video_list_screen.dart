import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/demo/demo_data.dart';
import 'video_player_screen.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  final List<String> _categories = [
    'Semua',
    'Jaringan',
    'Hardware',
    'Subnetting',
    'MikroTik',
    'Fiber Optic',
  ];

  @override
  Widget build(BuildContext context) {
    final videos = DemoData.tjktVideos.where((v) {
      final matchesCategory = _selectedCategory == 'Semua' || v.category == _selectedCategory;
      final matchesQuery = v.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          v.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Pembelajaran TJKT', style: NalarTextStyles.heading2),
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
                  hintText: 'Cari video tutorial (Pengkabelan, Subnetting)...',
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

            // Category Chips Filter
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedCategory = cat);
                        }
                      },
                      selectedColor: NalarColors.primaryCoral,
                      backgroundColor: NalarColors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? NalarColors.white : NalarColors.charcoal,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: NalarRadius.borderMd,
                        side: BorderSide(
                          color: isSelected ? NalarColors.primaryCoral : NalarColors.border,
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Video Cards List
            Expanded(
              child: videos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_library_outlined, size: 48, color: NalarColors.secondaryText),
                          const SizedBox(height: 12),
                          const Text('Video tidak ditemukan', style: NalarTextStyles.heading3),
                          const SizedBox(height: 4),
                          const Text('Coba pilih kategori atau pencarian lain.', style: NalarTextStyles.bodySmall),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: NalarCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VideoPlayerScreen(video: video),
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Thumbnail Preview Image Box
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                      child: Image.network(
                                        video.thumbnailUrl,
                                        width: double.infinity,
                                        height: 160,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 160,
                                            color: const Color(0xFF2C3E50),
                                            child: const Center(
                                              child: Icon(Icons.ondemand_video_rounded, color: Colors.white, size: 48),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Play Icon Overlay
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: NalarColors.primaryCoral.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                                      ),
                                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                                    ),
                                    // Duration Badge
                                    Positioned(
                                      right: 12,
                                      bottom: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.75),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          video.duration,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: NalarColors.softCoral,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              video.category,
                                              style: const TextStyle(
                                                color: NalarColors.primaryCoral,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          const Icon(Icons.play_circle_fill_rounded, color: NalarColors.primaryCoral, size: 16),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'YouTube Tutorial',
                                            style: TextStyle(
                                              color: NalarColors.primaryCoral,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(video.title, style: NalarTextStyles.heading3),
                                      const SizedBox(height: 4),
                                      Text(
                                        video.description,
                                        style: NalarTextStyles.bodySmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
