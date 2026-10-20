enum NotificationCategory {
  all('Semua'),
  learning('Belajar'),
  borrowing('Peminjaman'),
  project('Project'),
  attendance('Absensi');

  final String label;
  const NotificationCategory(this.label);
}

class NalarNotification {
  final String id;
  final String title;
  final String body;
  final NotificationCategory category;
  final DateTime timestamp;
  bool isRead;

  NalarNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.timestamp,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'category': category.name,
        'timestamp': timestamp.toIso8601String(),
        'isRead': isRead,
      };

  factory NalarNotification.fromJson(Map<String, dynamic> json) => NalarNotification(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        category: NotificationCategory.values.firstWhere(
          (e) => e.name == json['category'],
          orElse: () => NotificationCategory.learning,
        ),
        timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
        isRead: json['isRead'] ?? false,
      );
}
