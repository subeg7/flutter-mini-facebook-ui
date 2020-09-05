import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';

class Post {
  User user;
  List<String> images; //TODO :: remove this and its usages
  List<AppImageModel> appImages;
  String caption;

  Post({this.user, this.images, this.caption});

  Post.fromJson(json) {
    user = loggedInUser;
    images =
        json["images"].length > 0 ? json["images"] : []; //TODO :: remove this
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
}
