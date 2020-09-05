import 'package:facebook/models/models.dart';
import 'package:facebook/services/news_feed_service.dart';
import 'package:flutter/material.dart';

class NewsFeed with ChangeNotifier {
  List<Post> posts = [];
  NewsFeedService service = new NewsFeedService();
  bool isFetchingPage1 = false;
  int currentPage = 1;

  fetchPost({
    page = 1,
    successCb,
    dataCompleteCb,
  }) async {
    if (page == 1) isFetchingPage1 = true;
    notifyListeners();
    try {
      List<Post> paginatedPosts = await service.fetchByPage(page);
      posts = [...posts, ...paginatedPosts];
      if (page == 1) isFetchingPage1 = false;
      currentPage = page;
      notifyListeners();
      if (paginatedPosts.isEmpty)
        dataCompleteCb();
      else
        successCb();
    } catch (err) {
      if (page == 1) isFetchingPage1 = false;
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
