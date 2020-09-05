import 'package:facebook/models/news_feed_model.dart';
import 'package:facebook/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsFeed>(create: (context) => NewsFeed()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: NewsFeedScreen()),
    );
  }
}

class AppTextStyle {
  static TextStyle userName(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          letterSpacing: -0.5,
        );
  }
}
