import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PostHeader extends StatelessWidget {
  final String profileImage;
  final String title;
  final Function onEditPress;
  final int index;

  const PostHeader({
    Key key,
    @required this.profileImage,
    @required this.title,
    @required this.onEditPress,
    @required this.index,
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
          Indicator(digit : index),
          IconButton(
            key : ValueKey("edit-icon"),
            icon: Icon(Icons.edit),
            onPressed: () {
              onEditPress(context);
            },
          ),
        ],
      ),
    );
  }
}
