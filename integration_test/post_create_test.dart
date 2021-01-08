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

  testWidgets("create button onpress should navigate to ADD POST",
      (WidgetTester tester) async {
    await _pumpAppAndWait(tester);

    //press create new post
    Finder addNewFind = find.byKey(Key("whats-on-your-mind-text"));
    await tester.tap(addNewFind);
    await tester.pumpAndSettle();

    //check navigation
    Finder screenTititleFinder =
        find.byKey(ValueKey("Post-add-or-edit-screen-title-text"));
    Text screenTextWidget =
        screenTititleFinder.evaluate().single.widget as Text;
    expect(screenTextWidget.data, "ADD POST");
  });

  // testWidgets(
  //     "Alert dialog box should appear when pressing back while editing and pressing 'yes' on dialog should bring back to news feed screen",
  //     (WidgetTester tester) async {
  //   await _pumpAppAndWait(tester);
  //   Finder editButtonsBeforeNavigation = find.byKey(ValueKey("edit-icon"));
  //   await tester.tap(editButtonsBeforeNavigation.first);
  //   await tester.pumpAndSettle();

  //   //edit the post with NEWTEXT
  //   final String editText = "NEW EDIT TEXT FROM INTEGRATION TEST";
  //   await tester.enterText(find.byKey(Key("post-text-area")), editText);

  //   //go back without submitting
  //   Finder backFinder = find.byKey(ValueKey("back-button"));
  //   await tester.tap(backFinder);
  //   await tester.pumpAndSettle();
  //   // await Future.delayed(Duration(seconds: 5), () {});

  //   //find alertdialog box and check error message
  //   Finder dialogFinder = find.byKey(Key("go-back-alert-dialog"));
  //   expect(dialogFinder, findsOneWidget);

  //   // press yes button on dialog
  //   Finder yesDialogButton = find.byKey(Key("yes-button-on-dialog"));
  //   await tester.tap(yesDialogButton);
  //   await tester.pumpAndSettle();

  //   //check navigation
  //   Finder mainScreenTitleFinder =
  //       find.byKey(ValueKey("News-feed-screen-title-text"));
  //   Text mainScreenTitleWidget =
  //       mainScreenTitleFinder.evaluate().single.widget as Text;
  //   expect(mainScreenTitleWidget.data, "My Facebook");
  // });

  // testWidgets(
  //     "Alert dialog box should appear when pressing back while editing and pressing 'no' and then submitting the post should show text on news feed screen",
  //     (WidgetTester tester) async {
  //   await _pumpAppAndWait(tester);

  //   //navigate to edit screen
  //   Finder editButtonsBeforeNavigation = find.byKey(ValueKey("edit-icon"));
  //   await tester.tap(editButtonsBeforeNavigation.first);
  //   await tester.pumpAndSettle();

  //   // await Future.delayed(Duration(seconds: 5), () {});

  //   //edit the post with NEWTEXT
  //   final String editText = "NEW EDIT TEXT FROM INTEGRATION TEST";
  //   await tester.enterText(find.byKey(Key("post-text-area")), editText);

  //   //try going back without submitting
  //   Finder backFinder = find.byKey(ValueKey("back-button"));
  //   await tester.tap(backFinder);
  //   await tester.pumpAndSettle();
  //   // await Future.delayed(Duration(seconds: 5), () {});

  //   //find alertdialog box and check error message
  //   Finder dialogFinder = find.byKey(Key("go-back-alert-dialog"));
  //   expect(dialogFinder, findsOneWidget);

  //   // press no button on dialog
  //   Finder noDialogButton = find.byKey(Key("no-button-on-dialog"));
  //   await tester.tap(noDialogButton);
  //   await tester.pumpAndSettle();

  //   //press submit button
  //   Finder postSubmitButton = find.byKey(ValueKey("submit-button"));
  //   await tester.tap(postSubmitButton);
  //   await tester.pumpAndSettle();

  //   //check navigation
  //   Finder mainScreenTitleFinder =
  //       find.byKey(ValueKey("News-feed-screen-title-text"));
  //   Text mainScreenTitleWidget =
  //       mainScreenTitleFinder.evaluate().single.widget as Text;
  //   expect(mainScreenTitleWidget.data, "My Facebook");

  //   // find the edited text
  //   expect(find.text(editText), findsOneWidget);
  // });
}
