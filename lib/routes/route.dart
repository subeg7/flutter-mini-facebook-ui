import 'package:facebook/screens/screens.dart';
import 'package:flutter/material.dart';

var appRoute = <String, WidgetBuilder>{
  '/': (context) => NewsFeedScreen(),
  '/add-or-edit-post': (context) => AddOrEditScreen(),
};
