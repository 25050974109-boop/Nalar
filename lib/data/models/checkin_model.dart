class AttendanceCheckIn {
  final String id;
  final DateTime date;
  final String status;
  final String timeString;

  AttendanceCheckIn({
    required this.id,
    required this.date,
    required this.status,
    required this.timeString,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'status': status,
        'timeString': timeString,
      };

  factory AttendanceCheckIn.fromJson(Map<String, dynamic> json) => AttendanceCheckIn(
        id: json['id'] ?? '',
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
        status: json['status'] ?? 'Hadir',
        timeString: json['timeString'] ?? '',
      );
}
