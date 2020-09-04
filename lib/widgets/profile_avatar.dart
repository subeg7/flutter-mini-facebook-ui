import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String image;

  const ProfileAvatar({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage(image),
    );
  }
}
