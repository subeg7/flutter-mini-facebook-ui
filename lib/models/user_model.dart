import 'dart:core';

import 'package:facebook/constants.dart';

class User {
  final String name;
  final String profileImage;

  User(this.name, this.profileImage);
}

User loggedInUser = new User("Subeg Aryal", profilePic);
