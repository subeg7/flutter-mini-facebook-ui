import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';
import 'package:flutter/foundation.dart';

class Post {
  User user;
  List<AppImageModel> appImages = [];
  String caption;

  Post() {
    user = loggedInUser;
  }

  /*
    Create post by json data
  */
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

  /*
    Create post from data
  */
  Post.fromData(caption, images) {
    this.user = loggedInUser;
    this.appImages = images;
    this.caption = caption;
    if (this.caption.isEmpty) this.caption = null;
  }

  /* 
    This is operator overloading 
  */
  bool operator ==(covariant Post other) {
    bool areImageSame = listEquals(appImages, other.appImages);
    return caption == other.caption && areImageSame;
  }
}
