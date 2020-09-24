
import 'package:facebook/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsFeedProvider = ChangeNotifierProvider<NewsFeed>((ref) {
  return NewsFeed();
});