import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/models/video_model.dart';

class VideoPlayerScreen extends StatelessWidget {
  final TjktVideo video;

  const VideoPlayerScreen({super.key, required this.video});

  Future<void> _launchYouTubeUrl(BuildContext context) async {
    final Uri url = Uri.parse(video.youtubeUrl);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        await launchUrl(url, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Membuka video "${video.title}" di YouTube...'),
            backgroundColor: NalarColors.primaryCoral,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NalarAppBar(title: video.title),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Thumbnail Play Player Container
              InkWell(
                onTap: () => _launchYouTubeUrl(context),
                borderRadius: NalarRadius.borderLg,
                child: NalarCard(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: NalarRadius.borderLg,
                        child: Image.network(
                          video.thumbnailUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: const Color(0xFF1E2638),
                              child: const Center(
                                child: Icon(Icons.ondemand_video_rounded, color: Colors.white, size: 64),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: NalarColors.primaryCoral.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 12)],
                        ),
                        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
                      ),
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            video.duration,
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title & Category
              Row(
                children: [
                  Chip(
                    label: Text(video.category),
                    backgroundColor: NalarColors.softCoral,
                    labelStyle: const TextStyle(color: NalarColors.primaryCoral, fontWeight: FontWeight.bold, fontSize: 11),
                    side: BorderSide.none,
                  ),
                  const Spacer(),
                  const Icon(Icons.schedule_rounded, size: 16, color: NalarColors.secondaryText),
                  const SizedBox(width: 4),
                  Text(video.duration, style: NalarTextStyles.caption),
                ],
              ),
              const SizedBox(height: 8),

              Text(video.title, style: NalarTextStyles.heading1),
              const SizedBox(height: 12),

              // Launch Button
              NalarButton(
                text: 'Tonton Video di YouTube',
                icon: Icons.open_in_new_rounded,
                fullWidth: true,
                onPressed: () => _launchYouTubeUrl(context),
              ),
              const SizedBox(height: 20),

              // Description
              Text('Ringkasan Video', style: NalarTextStyles.heading2),
              const SizedBox(height: 6),
              NalarCard(
                child: Text(
                  video.description,
                  style: NalarTextStyles.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),

              // Key Takeaways Card
              NalarCard(
                backgroundColor: NalarColors.softCoral.withOpacity(0.5),
                borderColor: NalarColors.brightCoral.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb_rounded, color: NalarColors.primaryCoral, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Poin Penting Praktikum:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: NalarColors.primaryCoral, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildPointItem('Pahami urutan langkah-langkah praktikum sebelum mempraktikkan.'),
                    _buildPointItem('Gunakan peralatan laboratorium sesuai prosedur K3.'),
                    _buildPointItem('Uji ulang hasil konfigurasi atau pengkabelan untuk memastikan konektivitas.'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: NalarColors.primaryCoral)),
          Expanded(child: Text(text, style: NalarTextStyles.bodySmall)),
        ],
      ),
    );
  }
}
