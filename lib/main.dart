import 'dart:async';

import 'package:facebook/screens/screens.dart';
import 'package:facebook/sentry/sentry_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry/sentry.dart';

void main() {
  runZonedGuarded(
    () => runApp(ProviderScope(child: MyApp())),
    (error, stackTrace) async {
      try {
        await sentry.capture(
          event: Event(
            level: SeverityLevel.fatal,
            message: "Major Exception in debug [Please Ignore]",
            extra: {
              'time': "10 32 pm ",
              'error': error.toString(),
            },
            exception: error,
            stackTrace: stackTrace,
          ),
        );
        print("error reporting to sentry succesful");
      } catch (err) {
        print("couldn't be sent to sentry");
      }
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NewsFeedScreen(), // we begin with the NewsFeedScreen
    );
  }
}

/*
  AppTextStyle provides an easily editable and maintainable text styles 
  which are used over the app by different texts.
*/
class AppTextStyle {
  //facebook like title styles
  static TextStyle title(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          letterSpacing: -0.5,
        );
  }

  //facebook like subtitle styles
  static TextStyle subTitle(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
          fontSize: 15,
        );
  }
}
