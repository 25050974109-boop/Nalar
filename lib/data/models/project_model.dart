class ProjectChecklistItem {
  final String id;
  final String taskName;
  bool isCompleted;

  ProjectChecklistItem({
    required this.id,
    required this.taskName,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'taskName': taskName,
        'isCompleted': isCompleted,
      };

  factory ProjectChecklistItem.fromJson(Map<String, dynamic> json) => ProjectChecklistItem(
        id: json['id'] ?? '',
        taskName: json['taskName'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
      );
}

class StudentProject {
  final String id;
  final String title;
  final String description;
  final String objective;
  final String targetDate;
  final List<ProjectChecklistItem> checklist;
  String studentNotes;
  bool isCompleted;

  StudentProject({
    required this.id,
    required this.title,
    required this.description,
    required this.objective,
    required this.targetDate,
    required this.checklist,
    this.studentNotes = '',
    this.isCompleted = false,
  });

  double get progressPercentage {
    if (checklist.isEmpty) return 0;
    int completedCount = checklist.where((item) => item.isCompleted).length;
    return (completedCount / checklist.length) * 100;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'objective': objective,
        'targetDate': targetDate,
        'checklist': checklist.map((e) => e.toJson()).toList(),
        'studentNotes': studentNotes,
        'isCompleted': isCompleted,
      };

  factory StudentProject.fromJson(Map<String, dynamic> json) => StudentProject(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        objective: json['objective'] ?? '',
        targetDate: json['targetDate'] ?? '',
        checklist: (json['checklist'] as List<dynamic>?)
                ?.map((e) => ProjectChecklistItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        studentNotes: json['studentNotes'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
      );
}
