import 'package:facebook/models/post_model.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key key, this.post}) : super(key: key);
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
              userName: post.user.name,
            ),
            const Divider(color: Colors.black),
            post.caption != null
                ? Caption(
                    text: post.caption,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
