import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String image;
  final double radius;

  const ProfileAvatar({Key key, this.image, this.radius = 25.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(image),
    );
  }
}
