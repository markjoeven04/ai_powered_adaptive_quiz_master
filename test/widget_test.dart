// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brightspark_self_review/main.dart';
import 'package:brightspark_self_review/core/services/storage_service.dart';
import 'package:brightspark_self_review/core/providers/app_providers.dart';

void main() {
  testWidgets('BrightSpark App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final storageService = await StorageService.init();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageServiceProvider.overrideWithValue(storageService),
        ],
        child: const BrightSparkApp(),
      ),
    );

    // Initial splash frame verification
    expect(find.byType(BrightSparkApp), findsOneWidget);

    // Advance past splash transition timer
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
