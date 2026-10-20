import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/quiz_model.dart';
import '../models/borrowing_model.dart';
import '../models/project_model.dart';
import '../models/checkin_model.dart';
import '../models/notification_model.dart';
import '../models/chat_message.dart';

class NalarStorage {
  static const String keyProfile = 'nalar_user_profile';
  static const String keyCompletedSubchapters = 'nalar_completed_subchapters';
  static const String keyCompletedModules = 'nalar_completed_modules';
  static const String keyLastOpenedModuleId = 'nalar_last_module_id';
  static const String keyLastOpenedSubchapterId = 'nalar_last_subchapter_id';
  static const String keyQuizResults = 'nalar_quiz_results';
  static const String keyBorrowings = 'nalar_borrowings';
  static const String keyProjects = 'nalar_projects';
  static const String keyCheckIns = 'nalar_checkins';
  static const String keyNotifications = 'nalar_notifications';
  static const String keyChatMessages = 'nalar_chat_messages';
  static const String keyStreakDays = 'nalar_streak_days';
  static const String keyTotalLearningHours = 'nalar_learning_hours';
  static const String keyNotificationsEnabled = 'nalar_notifications_enabled';
  static const String keyIsInitialDemoLoaded = 'nalar_demo_loaded';

  final SharedPreferences _prefs;

  NalarStorage(this._prefs);

  static Future<NalarStorage> init() async {
    final prefs = await SharedPreferences.getInstance();
    return NalarStorage(prefs);
  }

  // Demo Initializer Flag
  bool get isDemoLoaded => _prefs.getBool(keyIsInitialDemoLoaded) ?? false;
  Future<void> setDemoLoaded(bool val) => _prefs.setBool(keyIsInitialDemoLoaded, val);

  // User Profile
  UserProfile getUserProfile() {
    final raw = _prefs.getString(keyProfile);
    if (raw == null) {
      return UserProfile.defaultProfile();
    }
    try {
      return UserProfile.fromJson(jsonDecode(raw));
    } catch (_) {
      return UserProfile.defaultProfile();
    }
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    await _prefs.setString(keyProfile, jsonEncode(profile.toJson()));
  }

  // Completed Subchapters
  Set<String> getCompletedSubchapters() {
    final list = _prefs.getStringList(keyCompletedSubchapters) ?? ['1_1', '1_2', '2_1', '3_1', '5_1'];
    return list.toSet();
  }

  Future<void> saveCompletedSubchapters(Set<String> subchapters) async {
    await _prefs.setStringList(keyCompletedSubchapters, subchapters.toList());
  }

  // Completed Modules
  Set<int> getCompletedModules() {
    final list = _prefs.getStringList(keyCompletedModules) ?? ['1', '2', '3', '4', '5'];
    return list.map((e) => int.tryParse(e) ?? 0).where((e) => e > 0).toSet();
  }

  Future<void> saveCompletedModules(Set<int> modules) async {
    await _prefs.setStringList(keyCompletedModules, modules.map((e) => e.toString()).toList());
  }

  // Last opened module & subchapter
  int getLastOpenedModuleId() => _prefs.getInt(keyLastOpenedModuleId) ?? 1;
  String getLastOpenedSubchapterId() => _prefs.getString(keyLastOpenedSubchapterId) ?? '1_1';

  Future<void> saveLastOpened(int moduleId, String subchapterId) async {
    await _prefs.setInt(keyLastOpenedModuleId, moduleId);
    await _prefs.setString(keyLastOpenedSubchapterId, subchapterId);
  }

  // Quiz Results
  List<QuizResult> getQuizResults() {
    final raw = _prefs.getStringList(keyQuizResults);
    if (raw == null) {
      return [
        QuizResult(
          moduleId: 1,
          moduleTitle: 'Pengenalan TJKT',
          score: 100,
          totalQuestions: 2,
          correctAnswers: 2,
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        QuizResult(
          moduleId: 5,
          moduleTitle: 'Dasar Jaringan Komputer',
          score: 80,
          totalQuestions: 2,
          correctAnswers: 2,
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
    }
    return raw.map((e) => QuizResult.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveQuizResults(List<QuizResult> results) async {
    final list = results.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(keyQuizResults, list);
  }

  // Borrowings
  List<BorrowingRecord> getBorrowings() {
    final raw = _prefs.getStringList(keyBorrowings);
    if (raw == null) {
      return [
        BorrowingRecord(
          id: 'borr_1',
          borrowerName: 'Raka Pratama',
          borrowerClass: 'X TJKT 1',
          itemName: 'Crimping Tool RJ45',
          quantity: 1,
          borrowDate: DateTime.now().subtract(const Duration(days: 2)),
          returnDate: DateTime.now().add(const Duration(days: 1)),
          purpose: 'Praktikum Mandiri Pengkabelan LAN',
          status: BorrowStatus.approved,
        )
      ];
    }
    return raw.map((e) => BorrowingRecord.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveBorrowings(List<BorrowingRecord> items) async {
    final list = items.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(keyBorrowings, list);
  }

  // Student Projects
  List<StudentProject> getStudentProjects(List<StudentProject> defaultProjects) {
    final raw = _prefs.getStringList(keyProjects);
    if (raw == null) return defaultProjects;
    try {
      return raw.map((e) => StudentProject.fromJson(jsonDecode(e))).toList();
    } catch (_) {
      return defaultProjects;
    }
  }

  Future<void> saveStudentProjects(List<StudentProject> projects) async {
    final list = projects.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(keyProjects, list);
  }

  // Attendance Check-ins
  List<AttendanceCheckIn> getCheckIns() {
    final raw = _prefs.getStringList(keyCheckIns);
    if (raw == null) {
      return [
        AttendanceCheckIn(
          id: 'check_1',
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: 'Hadir',
          timeString: '07:15 WIB',
        ),
      ];
    }
    return raw.map((e) => AttendanceCheckIn.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveCheckIns(List<AttendanceCheckIn> checkIns) async {
    final list = checkIns.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(keyCheckIns, list);
  }

  // Notifications
  List<NalarNotification> getNotifications(List<NalarNotification> defaultNotifs) {
    final raw = _prefs.getStringList(keyNotifications);
    if (raw == null) return defaultNotifs;
    return raw.map((e) => NalarNotification.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveNotifications(List<NalarNotification> notifs) async {
    final list = notifs.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(keyNotifications, list);
  }

  // Chat Messages
  List<ChatMessage> getChatMessages() {
    final raw = _prefs.getStringList(keyChatMessages);
    if (raw == null) {
      return [
        ChatMessage(
          id: 'c_init',
          sender: 'ai',
          text: 'Halo Raka! Saya Asisten AI NALAR. Ada materi TJKT atau soal jaringan yang ingin ditanyakan hari ini?',
          timestamp: DateTime.now(),
        ),
      ];
    }
    return raw.map((e) => ChatMessage.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveChatMessages(List<ChatMessage> messages) async {
    final list = messages.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(keyChatMessages, list);
  }

  // Streak & Hours
  int getStreakDays() => _prefs.getInt(keyStreakDays) ?? 7;
  Future<void> saveStreakDays(int days) => _prefs.setInt(keyStreakDays, days);

  double getTotalLearningHours() => _prefs.getDouble(keyTotalLearningHours) ?? 18.5;
  Future<void> saveTotalLearningHours(double hours) => _prefs.setDouble(keyTotalLearningHours, hours);

  bool getNotificationsEnabled() => _prefs.getBool(keyNotificationsEnabled) ?? true;
  Future<void> saveNotificationsEnabled(bool val) => _prefs.setBool(keyNotificationsEnabled, val);

  // Clear / Reset All Data
  Future<void> resetLearningData() async {
    await _prefs.remove(keyCompletedSubchapters);
    await _prefs.remove(keyCompletedModules);
    await _prefs.remove(keyQuizResults);
    await _prefs.setInt(keyStreakDays, 1);
    await _prefs.setDouble(keyTotalLearningHours, 0.0);
  }

  Future<void> clearAllDemoData() async {
    await _prefs.clear();
  }
}
