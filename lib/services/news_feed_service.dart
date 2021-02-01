import 'package:facebook/constants.dart';
import 'package:facebook/data/data.dart';
import 'package:facebook/models/models.dart';

class NewsFeedService {
  Future<List<Post>> fetchByPage(int page) async {
    await Future.delayed(Duration(seconds: kApiDelayInSeconds), () {});

    if (page == kPageLimit) return [];
    
    List<Post> posts = List<Post>.generate(
      initalPostsJson.length,
      (index) => Post.fromJson(initalPostsJson[index]),
    );
    return [...posts];
  }
}
