import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nalar/app.dart';
import 'package:nalar/data/local/nalar_storage.dart';
import 'package:nalar/providers/app_provider.dart';
import 'package:nalar/providers/ai_assistant_provider.dart';

void main() {
  testWidgets('NALAR App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final storage = NalarStorage(prefs);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider(storage)),
          ChangeNotifierProvider(create: (_) => AIAssistantProvider(storage)),
        ],
        child: const NalarApp(),
      ),
    );

    expect(find.text('NALAR'), findsWidgets);
  });
}
