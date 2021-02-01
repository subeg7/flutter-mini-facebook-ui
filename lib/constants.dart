import 'package:flutter/material.dart';

const kUserName = "Subeg Aryal";

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

const String addValidationMessage =
    "Please write something or atleast a image to post";
const String editValidationMessage =
    "Change something first, then it will be reflected on news feed";

final kValidationMessage = {
  "ScreenMode.ADD": addValidationMessage,
  "ScreenMode.EDIT": editValidationMessage,
};

const String dialogBoxTitle = "Go back ? ";
const String dialogBoxSubTitle =
    "Your change wont be saved if you leave. Are you sure of going back ? ";
const kBootMessage = "Please scroll to the bottom to see pagination in action";
