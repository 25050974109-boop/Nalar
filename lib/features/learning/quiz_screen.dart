import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/demo/demo_data.dart';
import '../../data/models/quiz_model.dart';
import '../../providers/app_provider.dart';
import '../progress/progress_screen.dart';

class QuizScreen extends StatefulWidget {
  final int moduleId;
  final String moduleTitle;

  const QuizScreen({
    super.key,
    required this.moduleId,
    required this.moduleTitle,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  bool _isSubmitted = false;
  QuizResult? _finalResult;

  @override
  Widget build(BuildContext context) {
    final questions = DemoData.quizQuestions
        .where((q) => q.moduleId == widget.moduleId)
        .toList();

    // Fallback if no specific questions exist for this module ID
    final activeQuestions = questions.isNotEmpty
        ? questions
        : DemoData.quizQuestions.take(2).toList();

    if (_isSubmitted && _finalResult != null) {
      return _buildResultScreen(context, activeQuestions);
    }

    final currentQuestion = activeQuestions[_currentQuestionIndex];
    final selectedOption = _selectedAnswers[_currentQuestionIndex];

    return Scaffold(
      appBar: NalarAppBar(
        title: 'Kuis: ${widget.moduleTitle}',
        onBackPressed: () => _confirmExit(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Question Progress Bar
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / activeQuestions.length,
              backgroundColor: NalarColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(NalarColors.primaryCoral),
              minHeight: 6,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Soal ${_currentQuestionIndex + 1} dari ${activeQuestions.length}',
                          style: NalarTextStyles.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: NalarColors.primaryCoral,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: NalarColors.softCoral,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Pilihan Ganda',
                            style: NalarTextStyles.caption.copyWith(
                              color: NalarColors.primaryCoral,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Question Text
                    Text(
                      currentQuestion.question,
                      style: NalarTextStyles.heading2,
                    ),
                    const SizedBox(height: 20),

                    // Options List
                    ...List.generate(currentQuestion.options.length, (optIndex) {
                      final optionText = currentQuestion.options[optIndex];
                      final isSelected = selectedOption == optIndex;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: NalarCard(
                          onTap: () {
                            setState(() {
                              _selectedAnswers[_currentQuestionIndex] = optIndex;
                            });
                          },
                          backgroundColor: isSelected ? NalarColors.softCoral : NalarColors.white,
                          borderColor: isSelected ? NalarColors.primaryCoral : NalarColors.border,
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isSelected ? NalarColors.primaryCoral : NalarColors.background,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? NalarColors.primaryCoral : NalarColors.border,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + optIndex), // A, B, C, D
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? NalarColors.white : NalarColors.charcoal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  optionText,
                                  style: NalarTextStyles.bodyMedium.copyWith(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? NalarColors.primaryCoral : NalarColors.charcoal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Bottom Navigation & Submit Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: NalarColors.white,
                border: Border(top: BorderSide(color: NalarColors.border)),
              ),
              child: Row(
                children: [
                  if (_currentQuestionIndex > 0)
                    Expanded(
                      child: NalarButton(
                        text: 'Sebelumnya',
                        type: NalarButtonType.outlined,
                        onPressed: () {
                          setState(() => _currentQuestionIndex--);
                        },
                      ),
                    ),
                  if (_currentQuestionIndex > 0) const SizedBox(width: 12),
                  if (_currentQuestionIndex < activeQuestions.length - 1)
                    Expanded(
                      child: NalarButton(
                        text: 'Berikutnya',
                        type: NalarButtonType.primary,
                        onPressed: () {
                          setState(() => _currentQuestionIndex++);
                        },
                      ),
                    )
                  else
                    Expanded(
                      child: NalarButton(
                        text: 'Kirim Jawaban',
                        icon: Icons.send_rounded,
                        type: NalarButtonType.primary,
                        onPressed: selectedOption == null
                            ? null
                            : () => _confirmSubmit(context, activeQuestions),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari Kuis?'),
        content: const Text('Jawaban yang sudah kamu pilih tidak akan tersimpan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  void _confirmSubmit(BuildContext context, List<QuizQuestion> questions) {
    if (_selectedAnswers.length < questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap jawab semua soal sebelum mengirim kuis.'),
          backgroundColor: NalarColors.primaryCoral,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kirim Jawaban Kuis?'),
        content: const Text('Pastikan kamu sudah memeriksa semua jawaban kuis.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Periksa Lagi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _calculateAndFinish(questions);
            },
            child: const Text('Ya, Kirim'),
          ),
        ],
      ),
    );
  }

  void _calculateAndFinish(List<QuizQuestion> questions) {
    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (_selectedAnswers[i] == questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }

    final score = ((correctCount / questions.length) * 100).round();

    final result = QuizResult(
      moduleId: widget.moduleId,
      moduleTitle: widget.moduleTitle,
      score: score,
      totalQuestions: questions.length,
      correctAnswers: correctCount,
      date: DateTime.now(),
    );

    final provider = Provider.of<AppProvider>(context, listen: false);
    provider.recordQuizResult(result);

    setState(() {
      _finalResult = result;
      _isSubmitted = true;
    });
  }

  Widget _buildResultScreen(BuildContext context, List<QuizQuestion> questions) {
    final result = _finalResult!;
    final isPassed = result.score >= 70;

    return Scaffold(
      appBar: NalarAppBar(
        title: 'Hasil Kuis',
        showBackButton: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Score Banner Card
              NalarCard(
                padding: const EdgeInsets.all(20),
                backgroundColor: isPassed ? NalarColors.softCoral : NalarColors.white,
                borderColor: isPassed ? NalarColors.brightCoral : NalarColors.border,
                child: Column(
                  children: [
                    Icon(
                      isPassed ? Icons.emoji_events_rounded : Icons.sentiment_dissatisfied_rounded,
                      size: 56,
                      color: isPassed ? NalarColors.primaryCoral : NalarColors.secondaryText,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPassed ? 'Luar Biasa! Kuis Selesai' : 'Perlu Belajar Lagi',
                      style: NalarTextStyles.heading1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isPassed
                          ? 'Kamu telah memahami materi "${widget.moduleTitle}" dengan baik.'
                          : 'Jangan berkecil hati! Pelajari kembali pembahasan di bawah ini.',
                      textAlign: TextAlign.center,
                      style: NalarTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: NalarColors.primaryCoral,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Skor: ${result.score} / 100',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: NalarColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatText('Jawaban Benar', '${result.correctAnswers}', NalarColors.success),
                        Container(height: 30, width: 1, color: NalarColors.border),
                        _buildStatText('Jawaban Salah', '${result.totalQuestions - result.correctAnswers}', NalarColors.primaryCoral),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Discussion / Pembahasan Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Pembahasan Soal', style: NalarTextStyles.heading2),
              ),
              const SizedBox(height: 10),

              ...List.generate(questions.length, (idx) {
                final q = questions[idx];
                final userChoice = _selectedAnswers[idx];
                final isCorrect = userChoice == q.correctAnswerIndex;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: NalarCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                              color: isCorrect ? NalarColors.success : NalarColors.primaryCoral,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text('Soal ${idx + 1}', style: NalarTextStyles.heading3),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(q.question, style: NalarTextStyles.bodyMedium),
                        const SizedBox(height: 8),
                        Text(
                          'Jawaban Kamu: ${userChoice != null ? q.options[userChoice] : "Belum Dijawab"}',
                          style: TextStyle(
                            fontSize: 13,
                            color: isCorrect ? NalarColors.success : NalarColors.primaryCoral,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (!isCorrect) ...[
                          const SizedBox(height: 2),
                          Text(
                            'Jawaban Benar: ${q.options[q.correctAnswerIndex]}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: NalarColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: NalarColors.background,
                            borderRadius: NalarRadius.borderSm,
                          ),
                          child: Text(
                            'Penjelasan: ${q.explanation}',
                            style: NalarTextStyles.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Action Buttons
              NalarButton(
                text: 'Ulangi Kuis',
                icon: Icons.refresh_rounded,
                type: NalarButtonType.outlined,
                fullWidth: true,
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _selectedAnswers.clear();
                    _isSubmitted = false;
                    _finalResult = null;
                  });
                },
              ),
              const SizedBox(height: 10),
              NalarButton(
                text: 'Kembali ke Materi',
                icon: Icons.menu_book_rounded,
                type: NalarButtonType.secondary,
                fullWidth: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              NalarButton(
                text: 'Lihat Progres Belajar',
                icon: Icons.insights_rounded,
                type: NalarButtonType.primary,
                fullWidth: true,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProgressScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatText(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: NalarTextStyles.caption),
      ],
    );
  }
}
