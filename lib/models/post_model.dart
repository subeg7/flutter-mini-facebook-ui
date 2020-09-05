import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';

class Post {
  User user;
  List<AppImageModel> appImages = [];
  String caption;

  Post.fromJson(json) {
    user = loggedInUser;
    caption = json["caption"];
    if (json["images"].length > 0) {
      //list.isEmpty cannot be used in if expression
      appImages = List<AppImageModel>.generate(
        json["images"].length,
        (index) => AppImageModel.fromNetwork(
          json["images"][index],
        ),
      );
    }
  }

  Post.edited(caption, images) {
    this.user = loggedInUser;
    this.caption = caption;
    this.appImages = images;
  }

  //This is operator overloading
  bool operator ==(covariant Post other) {
    return caption == other.caption && appImages == other.appImages;
  }
}
