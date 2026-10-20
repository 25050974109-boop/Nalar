class SubChapter {
  final String id;
  final String title;
  final String content;

  SubChapter({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };

  factory SubChapter.fromJson(Map<String, dynamic> json) => SubChapter(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        content: json['content'] ?? '',
      );
}

class LearningModule {
  final int id;
  final String title;
  final String description;
  final String iconName;
  final String estimatedTime;
  final String objective;
  final List<SubChapter> subChapters;

  LearningModule({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.estimatedTime,
    required this.objective,
    required this.subChapters,
  });
}
