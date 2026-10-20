import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/local/nalar_storage.dart';
import 'providers/app_provider.dart';
import 'providers/ai_assistant_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await NalarStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(storage)),
        ChangeNotifierProvider(create: (_) => AIAssistantProvider(storage)),
      ],
      child: const NalarApp(),
    ),
  );
}
