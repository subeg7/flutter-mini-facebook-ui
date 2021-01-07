import 'package:facebook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
// On edit icon press, screen should navigate to the edit screen
  testWidgets("at least a edit icon should be present",
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    Finder editButtons = find.byKey(ValueKey("edit-icon"));
    expect(editButtons.first, findsOneWidget);
  });

}