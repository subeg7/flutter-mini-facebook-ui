import 'package:facebook/models/models.dart';
import 'package:facebook/services/news_feed_service.dart';
import 'package:flutter/material.dart';

class NewsFeed with ChangeNotifier {
  List<Post> posts = []; //this is rendered in newsFeedScreen
  NewsFeedService service = new NewsFeedService(); //this simulates the api call
  bool isFetchingPage1 = true;
  int currentPage = 1; //the current page of data fetched

  /*
   Here, the paginated data is fetched,
   successCB is triggered if the fetched data is not empty,
   dataCompleteCb is triggered if the data is empty,
   these callbacks affect when user scroll down on NewsFeedScreen
  */
  fetchPost({
    page = 1,
    successCb,
    dataCompleteCb,
  }) async {
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

  /*
    Here, adding a post is just adding the new instance of Post to the this.posts .
    Inserting it at the 0th index ensures the new post to appear at the top.
    validations are already done with helper functions.
  */
  add(Post post, int index, {Function successCb}) {
    posts.insert(0, post);
    notifyListeners();
    successCb();
  }

  /*
    Logic behind editing is very simple yet effective,
    replacing the new instance of Post in the index (in this.posts)
    of the original post. 
    validations are already done with helper functions.
    */
  replace(Post post, int index, {Function successCb}) {
    int startIndex = index;
    int endIndex = index + 1;
    posts.replaceRange(
        startIndex, endIndex, [post]); //start is inclusive but end is exclusive
    notifyListeners();
    successCb();
  }
}
