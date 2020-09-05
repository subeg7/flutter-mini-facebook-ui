import 'package:facebook/screens/screens.dart';
import 'package:flutter/material.dart';

var appRoute = <String, WidgetBuilder>{
  '/news-feed': (context) => NewsFeedScreen(),
  '/add-or-edit-post': (context) => AddOrEditScreen(),
};
