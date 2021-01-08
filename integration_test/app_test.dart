import 'package:facebook/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  _pumpAppAndWait(tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();
  }

  // _navagiteToSecondayScreen(tester, ValueKey key, String screenTitle) async {
  //   await _pumpAppAndWait(tester);
  //   Finder editButtonsBeforeNavigation = find.byKey(ValueKey("edit-icon"));
  //   await tester.tap(editButtonsBeforeNavigation.first);
  //   await tester.pumpAndSettle();
  //   Finder screenTititleFinder = find.byKey(key);
  //   Text screenTextWidget =
  //       screenTititleFinder.evaluate().single.widget as Text;
  //   expect(screenTextWidget.data, screenTitle);
  // }

// // On edit icon press, screen should navigate to the edit screen
//   testWidgets("at least a edit icon should be present",
//       (WidgetTester tester) async {
//     await _pumpAppAndWait(tester);
//     Finder editButtons = find.byKey(ValueKey("edit-icon"));
//     expect(editButtons.first, findsOneWidget);
//   });

  testWidgets(
      "tapping on edit button should navigate to the edit screen with screen title 'Edit' on top",
      (WidgetTester tester) async {
    await _pumpAppAndWait(tester);
    Finder editButtonsBeforeNavigation = find.byKey(ValueKey("edit-icon"));
    await tester.tap(editButtonsBeforeNavigation.first);
    await tester.pumpAndSettle();
    Finder screenTititleFinder =
        find.byKey(ValueKey("Post-add-or-edit-screen-title-text"));
    Text screenTextWidget =
        screenTititleFinder.evaluate().single.widget as Text;
    expect(screenTextWidget.data, "EDIT POST");

    //go back without editing
    Finder backFinder = find.byKey(ValueKey("back-button"));
    await tester.tap(backFinder);
    await tester.pumpAndSettle();
    Finder mainScreenTitleFinder =
        find.byKey(ValueKey("News-feed-screen-title-text"));
    Text mainScreenTitleWidget =
        mainScreenTitleFinder.evaluate().single.widget as Text;
    expect(mainScreenTitleWidget.data, "My Facebook");

    // await Future.delayed(Duration(seconds: 5), () {});

    //again navigate to the edit screen the post with NEWTEXT
    await tester.tap(editButtonsBeforeNavigation.first);
    await tester.pumpAndSettle();
    expect(screenTextWidget.data, "EDIT POST");

    //edit the post with NEWTEXT
    final String editText = "NEW EDIT TEXT FROM INTEGRATION TEST";
    await tester.enterText(find.byKey(Key("post-text-area")), editText);
    await tester.tap(backFinder);
    await tester.pumpAndSettle();
    // await Future.delayed(Duration(seconds: 5), () {});

    //press submit button
    //find alertdialog box and check error message

    // go back
    //should find the NEWTEXT

    // Finder submitFind = find.byKey(ValueKey("submit-button"));
    // expect(submitFind, findsOneWidget);

    // await tester.tap(submitFind);
  });
}
