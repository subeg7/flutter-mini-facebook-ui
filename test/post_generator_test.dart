import 'package:facebook/data/data.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/services/news_feed_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Populating the Initial Posts", () async {
    List<Post> posts = await NewsFeedService().fetchByPage(1);
    expect(initalPostsJson.length, posts.length);
  });
}
