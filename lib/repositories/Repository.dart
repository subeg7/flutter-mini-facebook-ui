import 'package:facebook/models/post_model.dart';
import 'package:facebook/services/news_feed_service.dart';

class Repository {
  NewsFeedService _newsFeedService = NewsFeedService();

  Future<List<Post>> fetchByPage(int page) =>
      _newsFeedService.fetchByPage(page);
}
