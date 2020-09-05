import 'package:facebook/models/models.dart';
import 'package:facebook/services/news_feed_service.dart';
import 'package:flutter/material.dart';

class NewsFeed with ChangeNotifier {
  List<Post> posts = [];
  NewsFeedService service = new NewsFeedService();

  bool isLoading = false;

  fetchPost({page = 1}) async {
    isLoading = true;
    notifyListeners();
    try {
      posts = await service.fetchByPage(page);
      isLoading = false;
      notifyListeners();
    } catch (err) {
      isLoading = false;
      notifyListeners();
    }
  }

  add(Post post, int index, {Function successCb}) {
    posts.insert(0, post);
    notifyListeners();
    successCb();
  }

  replace(Post post, int index, {Function successCb}) {
    posts.replaceRange(
        index, index + 1, [post]); //start is inclusive but end is exclusive
    notifyListeners();
    successCb();
  }
}
