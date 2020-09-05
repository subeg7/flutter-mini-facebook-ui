import 'package:facebook/constants.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/routes/scale_route.dart';
import 'package:facebook/screens/screens.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final int index;
  const PostCard({Key key, this.post, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(
              profileImage: post.user.profileImage,
              title: post.user.name,
              onEditPress: _handleOnEditPress,
              index: index,
            ),
            const Divider(color: Colors.black),
            post.caption != null
                ? Caption(
                    text: post.caption,
                  )
                : SizedBox(),
            post.appImages.isNotEmpty
                ? GridImage(appImages: post.appImages)
                : SizedBox(
                    height: 25,
                  ),
          ],
        ),
      ),
    );
  }

  _handleOnEditPress(BuildContext context) {
    Navigator.push(
      context,
      ScaleRoute(
        page: AddOrEditScreen(
          post: post,
          index: index,
          mode: ScreenMode.EDIT,
        ),
      ),
    );
  }
}
