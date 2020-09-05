import 'package:facebook/constants.dart';
import 'package:facebook/data/data.dart';
import 'package:facebook/models/models.dart';

class NewsFeedService {
  Future<List<Post>> fetchByPage(int page) async {
    await Future.delayed(Duration(seconds: kApiDelayInSeconds), () {});
    List<Post> posts = List<Post>.generate(
      initalPostsJson.length,
      (index) => Post.fromJson(initalPostsJson[index]),
    );
    return [
      ...posts,
      // ...posts,
      // ...posts,
      // ...posts,
      // ...posts,
      // ...posts,
      // ...posts,
      // ...posts,
      // ...posts,
      // ...posts,
    ];
  }
}
