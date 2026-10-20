class QuizQuestion {
  final String id;
  final int moduleId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.moduleId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuizResult {
  final int moduleId;
  final String moduleTitle;
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final DateTime date;

  QuizResult({
    required this.moduleId,
    required this.moduleTitle,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'moduleId': moduleId,
        'moduleTitle': moduleTitle,
        'score': score,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'date': date.toIso8601String(),
      };

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        moduleId: json['moduleId'] ?? 1,
        moduleTitle: json['moduleTitle'] ?? '',
        score: json['score'] ?? 0,
        totalQuestions: json['totalQuestions'] ?? 5,
        correctAnswers: json['correctAnswers'] ?? 0,
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      );
}
