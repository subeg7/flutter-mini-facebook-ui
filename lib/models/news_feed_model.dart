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

  addNewPost(Post post) {
    //TODO :: add a new post
  }

  editPost(Post post) {
    //TODO :: edit logic here
  }
}
