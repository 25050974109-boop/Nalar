import 'package:flutter/foundation.dart';
import '../data/local/nalar_storage.dart';
import '../data/demo/demo_data.dart';
import '../data/models/user_profile.dart';
import '../data/models/module_model.dart';
import '../data/models/quiz_model.dart';
import '../data/models/borrowing_model.dart';
import '../data/models/project_model.dart';
import '../data/models/checkin_model.dart';
import '../data/models/notification_model.dart';
import '../data/models/badge_model.dart';

class AppProvider extends ChangeNotifier {
  final NalarStorage storage;

  late UserProfile _profile;
  late Set<String> _completedSubchapters;
  late Set<int> _completedModules;
  late List<QuizResult> _quizResults;
  late List<BorrowingRecord> _borrowings;
  late List<StudentProject> _projects;
  late List<AttendanceCheckIn> _checkIns;
  late List<NalarNotification> _notifications;
  late int _streakDays;
  late double _learningHours;
  late bool _notificationsEnabled;

  int _currentBottomNavIndex = 0;

  AppProvider(this.storage) {
    _loadAllData();
  }

  void _loadAllData() {
    _profile = storage.getUserProfile();
    _completedSubchapters = storage.getCompletedSubchapters();
    _completedModules = storage.getCompletedModules();
    _quizResults = storage.getQuizResults();
    _borrowings = storage.getBorrowings();
    _projects = storage.getStudentProjects(DemoData.studentProjects);
    _checkIns = storage.getCheckIns();
    _notifications = storage.getNotifications(DemoData.initialNotifications);
    _streakDays = storage.getStreakDays();
    _learningHours = storage.getTotalLearningHours();
    _notificationsEnabled = storage.getNotificationsEnabled();
  }

  // Getters
  UserProfile get profile => _profile;
  Set<String> get completedSubchapters => _completedSubchapters;
  Set<int> get completedModules => _completedModules;
  List<QuizResult> get quizResults => _quizResults;
  List<BorrowingRecord> get borrowings => _borrowings;
  List<StudentProject> get projects => _projects;
  List<AttendanceCheckIn> get checkIns => _checkIns;
  List<NalarNotification> get notifications => _notifications;
  int get streakDays => _streakDays;
  double get learningHours => _learningHours;
  bool get notificationsEnabled => _notificationsEnabled;
  int get currentBottomNavIndex => _currentBottomNavIndex;

  List<LearningModule> get allModules => DemoData.modules;

  // Bottom Nav Index Control
  void setBottomNavIndex(int index) {
    _currentBottomNavIndex = index;
    notifyListeners();
  }

  // Update Profile
  Future<void> updateProfile(UserProfile newProfile) async {
    _profile = newProfile;
    await storage.saveUserProfile(newProfile);
    notifyListeners();
  }

  // Subchapter & Module Completion Logic
  bool isSubchapterCompleted(String subChapterId) {
    return _completedSubchapters.contains(subChapterId);
  }

  bool isModuleCompleted(int moduleId) {
    return _completedModules.contains(moduleId);
  }

  Future<void> markSubchapterCompleted(int moduleId, String subChapterId) async {
    _completedSubchapters.add(subChapterId);
    await storage.saveCompletedSubchapters(_completedSubchapters);

    // Check if all subchapters of this module are read
    final module = DemoData.modules.firstWhere((m) => m.id == moduleId, orElse: () => DemoData.modules.first);
    bool allDone = module.subChapters.every((sub) => _completedSubchapters.contains(sub.id));

    if (allDone && !_completedModules.contains(moduleId)) {
      _completedModules.add(moduleId);
      await storage.saveCompletedModules(_completedModules);
      
      // Increment learning hours slightly
      _learningHours += 0.5;
      await storage.saveTotalLearningHours(_learningHours);

      addNotification(
        title: 'Modul Selesai!',
        body: 'Selamat! Kamu telah menyelesaikan modul "${module.title}".',
        category: NotificationCategory.learning,
      );
    }

    notifyListeners();
  }

  // Last opened module persistence
  Future<void> setLastOpened(int moduleId, String subchapterId) async {
    await storage.saveLastOpened(moduleId, subchapterId);
  }

  int get lastOpenedModuleId => storage.getLastOpenedModuleId();
  String get lastOpenedSubchapterId => storage.getLastOpenedSubchapterId();

  // Quiz Results
  Future<void> recordQuizResult(QuizResult result) async {
    _quizResults.insert(0, result);
    await storage.saveQuizResults(_quizResults);

    // Mark module completed if score >= 70
    if (result.score >= 70 && !_completedModules.contains(result.moduleId)) {
      _completedModules.add(result.moduleId);
      await storage.saveCompletedModules(_completedModules);
    }

    _learningHours += 0.2;
    await storage.saveTotalLearningHours(_learningHours);

    addNotification(
      title: 'Kuis Selesai',
      body: 'Nilai Kuis "${result.moduleTitle}": ${result.score}/100.',
      category: NotificationCategory.learning,
    );

    notifyListeners();
  }

  int get averageQuizScore {
    if (_quizResults.isEmpty) return 0;
    int sum = _quizResults.fold(0, (prev, element) => prev + element.score);
    return (sum / _quizResults.length).round();
  }

  // Attendance Check-In
  bool get isCheckedInToday {
    final now = DateTime.now();
    return _checkIns.any((c) =>
        c.date.year == now.year &&
        c.date.month == now.month &&
        c.date.day == now.day);
  }

  Future<bool> checkInToday() async {
    if (isCheckedInToday) return false;

    final now = DateTime.now();
    final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} WIB';
    
    final newCheckIn = AttendanceCheckIn(
      id: 'check_${now.millisecondsSinceEpoch}',
      date: now,
      status: 'Hadir',
      timeString: timeStr,
    );

    _checkIns.insert(0, newCheckIn);
    await storage.saveCheckIns(_checkIns);

    // Increase streak if newly checked in
    _streakDays += 1;
    await storage.saveStreakDays(_streakDays);

    addNotification(
      title: 'Check-In Berhasil',
      body: 'Pencatatan absensi harian berhasil disimpan pada $timeStr.',
      category: NotificationCategory.attendance,
    );

    notifyListeners();
    return true;
  }

  // Borrowings
  Future<void> addBorrowing(BorrowingRecord record) async {
    _borrowings.insert(0, record);
    await storage.saveBorrowings(_borrowings);

    addNotification(
      title: 'Pengajuan Peminjaman Disimpan',
      body: 'Permintaan peminjaman alat "${record.itemName}" telah dicatat.',
      category: NotificationCategory.borrowing,
    );

    notifyListeners();
  }

  Future<void> cancelBorrowing(String id) async {
    _borrowings.removeWhere((b) => b.id == id);
    await storage.saveBorrowings(_borrowings);
    notifyListeners();
  }

  // Projects
  Future<void> toggleProjectChecklist(String projectId, String checklistId) async {
    final projIndex = _projects.indexWhere((p) => p.id == projectId);
    if (projIndex != -1) {
      final checklist = _projects[projIndex].checklist;
      final checkIndex = checklist.indexWhere((c) => c.id == checklistId);
      if (checkIndex != -1) {
        checklist[checkIndex].isCompleted = !checklist[checkIndex].isCompleted;
        
        // Auto mark project completed if all tasks done
        if (checklist.every((c) => c.isCompleted)) {
          _projects[projIndex].isCompleted = true;
          addNotification(
            title: 'Project Selesai!',
            body: 'Selamat! Seluruh tugas pada project "${_projects[projIndex].title}" telah tuntas.',
            category: NotificationCategory.project,
          );
        } else {
          _projects[projIndex].isCompleted = false;
        }

        await storage.saveStudentProjects(_projects);
        notifyListeners();
      }
    }
  }

  Future<void> updateProjectNotes(String projectId, String notes) async {
    final projIndex = _projects.indexWhere((p) => p.id == projectId);
    if (projIndex != -1) {
      _projects[projIndex].studentNotes = notes;
      await storage.saveStudentProjects(_projects);
      notifyListeners();
    }
  }

  // Notifications
  Future<void> addNotification({
    required String title,
    required String body,
    required NotificationCategory category,
  }) async {
    final newNotif = NalarNotification(
      id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      body: body,
      category: category,
      timestamp: DateTime.now(),
      isRead: false,
    );
    _notifications.insert(0, newNotif);
    await storage.saveNotifications(_notifications);
    notifyListeners();
  }

  Future<void> markNotificationRead(String id) async {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      await storage.saveNotifications(_notifications);
      notifyListeners();
    }
  }

  int get unreadNotificationCount => _notifications.where((n) => !n.isRead).length;

  // Settings
  Future<void> toggleNotificationsEnabled(bool val) async {
    _notificationsEnabled = val;
    await storage.saveNotificationsEnabled(val);
    notifyListeners();
  }

  Future<void> resetLearningData() async {
    await storage.resetLearningData();
    _completedSubchapters.clear();
    _completedModules.clear();
    _quizResults.clear();
    _streakDays = 1;
    _learningHours = 0.0;
    notifyListeners();
  }

  Future<void> clearAllData() async {
    await storage.clearAllDemoData();
    _loadAllData();
    notifyListeners();
  }

  // Calculated Progress Metrics
  double get overallProgressPercentage {
    double modulePart = (_completedModules.length / 12.0) * 60.0; // 60% weight
    
    double projectPart = 0.0;
    if (_projects.isNotEmpty) {
      double totalProjProgress = _projects.fold(0.0, (sum, p) => sum + p.progressPercentage);
      projectPart = (totalProjProgress / (_projects.length * 100.0)) * 20.0; // 20% weight
    }

    double quizPart = 0.0;
    if (_quizResults.isNotEmpty) {
      quizPart = (averageQuizScore / 100.0) * 20.0; // 20% weight
    }

    double total = modulePart + projectPart + quizPart;
    return total.clamp(0.0, 100.0);
  }

  // Achievements Badges System
  List<AchievementBadge> get achievementBadges {
    return [
      AchievementBadge(
        id: 'b1',
        title: 'Pembelajar Pertama',
        description: 'Membuka subbab materi pertama.',
        iconName: 'school',
        isUnlocked: _completedSubchapters.isNotEmpty,
      ),
      AchievementBadge(
        id: 'b2',
        title: 'Modul Pertama Selesai',
        description: 'Menyelesaikan modul pertama secara penuh.',
        iconName: 'task_alt',
        isUnlocked: _completedModules.isNotEmpty,
      ),
      AchievementBadge(
        id: 'b3',
        title: 'Ahli Kuis Dasar',
        description: 'Mendapatkan nilai sempurna (100) pada salah satu kuis.',
        iconName: 'stars',
        isUnlocked: _quizResults.any((q) => q.score == 100),
      ),
      AchievementBadge(
        id: 'b4',
        title: 'Konsisten Belajar',
        description: 'Memiliki streak belajar minimal 3 hari.',
        iconName: 'local_fire_department',
        isUnlocked: _streakDays >= 3,
      ),
      AchievementBadge(
        id: 'b5',
        title: 'Teknisi Lab',
        description: 'Mengajukan peminjaman alat lab atau menyelesaikan absensi.',
        iconName: 'construction',
        isUnlocked: _borrowings.isNotEmpty || _checkIns.isNotEmpty,
      ),
    ];
  }
}
