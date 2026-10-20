import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../providers/ai_assistant_provider.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _suggestedQuestions = [
    'Apa perbedaan router dan switch?',
    'Jelaskan subnetting dengan contoh sederhana.',
    'Apa fungsi kabel UTP dan urutan warna T568B?',
    'Sebutkan 7 lapisan pada OSI Layer.',
  ];

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AIAssistantProvider>(context);

    return Scaffold(
      appBar: NalarAppBar(
        title: 'Asisten AI NALAR',
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded, color: NalarColors.charcoal),
            tooltip: 'Bersihkan Obrolan',
            onPressed: () => aiProvider.clearHistory(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Mode Banner Notice
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: NalarColors.softCoral,
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline_rounded, size: 16, color: NalarColors.primaryCoral),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Asisten AI menggunakan Mode Demo Lokal untuk membantu pertanyaan seputar materi TJKT.',
                      style: TextStyle(fontSize: 11, color: NalarColors.primaryCoral, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            // Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: aiProvider.messages.length,
                itemBuilder: (context, index) {
                  final msg = aiProvider.messages[index];
                  final isUser = msg.isUser;

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isUser ? NalarColors.primaryCoral : NalarColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 4),
                          bottomRight: Radius.circular(isUser ? 4 : 16),
                        ),
                        border: isUser ? null : Border.all(color: NalarColors.border),
                        boxShadow: const [
                          BoxShadow(color: NalarColors.cardShadow, blurRadius: 4, offset: Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isUser ? Icons.person_rounded : Icons.auto_awesome_rounded,
                                size: 14,
                                color: isUser ? NalarColors.white : NalarColors.primaryCoral,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isUser ? 'Kamu' : 'Asisten AI NALAR',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isUser ? NalarColors.white : NalarColors.primaryCoral,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          SelectableText(
                            msg.text,
                            style: TextStyle(
                              fontSize: 13,
                              color: isUser ? NalarColors.white : NalarColors.charcoal,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (aiProvider.isTyping)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: NalarColors.primaryCoral)),
                    SizedBox(width: 8),
                    Text('Asisten AI sedang menyusun jawaban...', style: NalarTextStyles.caption),
                  ],
                ),
              ),

            // Suggested Questions Chips
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _suggestedQuestions.length,
                itemBuilder: (context, index) {
                  final q = _suggestedQuestions[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      label: Text(q, style: const TextStyle(fontSize: 11, color: NalarColors.primaryCoral)),
                      backgroundColor: NalarColors.softCoral,
                      side: BorderSide.none,
                      onPressed: () {
                        aiProvider.sendMessage(q);
                        _scrollToBottom();
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 6),

            // Input Bar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: NalarColors.white,
                border: Border(top: BorderSide(color: NalarColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText: 'Tanyakan sesuatu tentang TJKT...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (val) {
                        if (val.trim().isNotEmpty) {
                          aiProvider.sendMessage(val.trim());
                          _inputController.clear();
                          _scrollToBottom();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: NalarColors.primaryCoral,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: NalarColors.white, size: 20),
                      onPressed: () {
                        final val = _inputController.text.trim();
                        if (val.isNotEmpty) {
                          aiProvider.sendMessage(val);
                          _inputController.clear();
                          _scrollToBottom();
                        }
                      },
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

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
