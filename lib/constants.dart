import 'package:flutter/material.dart';

const kPageLimit = 5;

const String profilePic =
    "https://images.pexels.com/photos/3772510/pexels-photo-3772510.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
const String laptop =
    "https://images.pexels.com/photos/4050290/pexels-photo-4050290.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
const kDefaultImage = laptop;

const kApiDelayInSeconds = 2;

enum ScreenMode { ADD, EDIT }

final kScreenModeTitleMap = {
  "ScreenMode.ADD": "Add",
  "ScreenMode.EDIT": "Edit",
};

final kSubmitButtonTitle = {
  "ScreenMode.ADD": "Add Post",
  "ScreenMode.EDIT": "Done Editing",
};

final kSubmitIconData = {
  "ScreenMode.ADD": Icons.add,
  "ScreenMode.EDIT": Icons.edit,
};

final kValidationMessage= {
  "ScreenMode.ADD": "Please write something or atleast a image to post",
  "ScreenMode.EDIT": "Change something first, then it will be reflected on news feed"
};
