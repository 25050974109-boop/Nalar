class TjktVideo {
  final String id;
  final String title;
  final String description;
  final String youtubeUrl;
  final String youtubeVideoId;
  final String duration;
  final String category;

  TjktVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeUrl,
    required this.youtubeVideoId,
    required this.duration,
    required this.category,
  });

  String get thumbnailUrl => 'https://img.youtube.com/vi/$youtubeVideoId/hqdefault.jpg';
}
