class AchievementBadge {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final bool isUnlocked;

  AchievementBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    this.isUnlocked = false,
  });
}
