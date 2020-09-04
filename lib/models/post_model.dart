import 'package:facebook/models/models.dart';

class Post {
  User user;
  List<String> images;
  String caption;

  Post({this.user, this.images, this.caption});

  Post.fromJson(json) {
    user = loggedInUser;  
    images = json["images"].length > 0  ? json["images"] : [];
    caption = json["caption"];
  }
}
