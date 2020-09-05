import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PostHeader extends StatelessWidget {
  final String profileImage;
  final String title;
  final Function onEditPress;

  const PostHeader({
    Key key,
    @required this.profileImage,
    @required this.title,
    @required this.onEditPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      // color: Colors.green  ,
      height: 70,
      child: Row(
        children: [
          ProfileAvatar(image: profileImage),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.title(context),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              onEditPress(context);
            },
          ),
        ],
      ),
    );
  }
}
