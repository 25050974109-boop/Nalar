import 'package:flutter/foundation.dart';
import '../data/local/nalar_storage.dart';
import '../data/demo/demo_data.dart';
import '../data/models/chat_message.dart';

class AIAssistantProvider extends ChangeNotifier {
  final NalarStorage storage;
  late List<ChatMessage> _messages;
  bool _isTyping = false;

  AIAssistantProvider(this.storage) {
    _messages = storage.getChatMessages();
  }

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'user',
      text: text.trim(),
      timestamp: DateTime.now(),
    );

    _messages.add(userMsg);
    _isTyping = true;
    notifyListeners();

    await storage.saveChatMessages(_messages);

    // Simulate AI thinking and generate local educational response
    await Future.delayed(const Duration(milliseconds: 900));

    final aiResponseText = _generateLocalResponse(text.trim());

    final aiMsg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch + 1}',
      sender: 'ai',
      text: aiResponseText,
      timestamp: DateTime.now(),
    );

    _messages.add(aiMsg);
    _isTyping = false;
    notifyListeners();

    await storage.saveChatMessages(_messages);
  }

  String _generateLocalResponse(String query) {
    final lower = query.toLowerCase();

    for (var entry in DemoData.aiKnowledgeBase.entries) {
      if (lower.contains(entry.key)) {
        return entry.value;
      }
    }

    if (lower.contains('halo') || lower.contains('hai') || lower.contains('pagi') || lower.contains('siang')) {
      return 'Halo! Saya Asisten AI NALAR. Silakan tanyakan apapun seputar Teknologi Jaringan Komputer dan Telekomunikasi (TJKT), seperti router, switch, IP address, kabel UTP, atau K3 laboratorium.';
    }

    if (lower.contains('terima kasih') || lower.contains('makasih') || lower.contains('thanks')) {
      return 'Sama-sama! Selalu semangat belajar TJKT. "Explore Technology. Connect Your Future."';
    }

    return 'Terima kasih atas pertanyaannya! Pada mode demo lokal NALAR, saya dapat menjawab pertanyaan seputar:\n- Perbedaan Router dan Switch\n- Konsep dan fungsi IP Address & Subnetting\n- Pengkabelan UTP & Fiber Optic\n- Topologi Jaringan (Star, Bus, Mesh)\n- K3 Laboratorium TJKT\n- Model OSI Layer\n\nCoba ketik salah satu kata kunci di atas!';
  }

  Future<void> clearHistory() async {
    _messages = [
      ChatMessage(
        id: 'c_init_${DateTime.now().millisecondsSinceEpoch}',
        sender: 'ai',
        text: 'Riwayat percakapan dibersihkan. Ada materi TJKT lain yang ingin kamu diskusikan?',
        timestamp: DateTime.now(),
      ),
    ];
    await storage.saveChatMessages(_messages);
    notifyListeners();
  }
}
