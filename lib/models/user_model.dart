import 'dart:core';

import 'package:facebook/constants.dart';

class User {
  final String name;
  final String profileImage;

  User(this.name, this.profileImage);
}

/* Every activity(add and edit) is done by this user */
User loggedInUser = new User(kUserName, profilePic,);
