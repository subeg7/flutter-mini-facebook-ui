import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String profileImage;
  final String userName;

  const PostHeader({
    Key key,
    @required this.profileImage,
    @required this.userName,
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
            userName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: -0.5),
          )),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
