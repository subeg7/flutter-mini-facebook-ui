import 'package:facebook/constants.dart';
import 'package:facebook/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showPopDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text(dialogBoxTitle),
      content: new Text(dialogBoxSubTitle),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('No'),
        ),
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: new Text('Yes'),
        ),
      ],
    ),
  );
}

submitByScreenMode(
  String text,
  List<AppImageModel> images,
  BuildContext context,
  int postIndex,
  ScreenMode currentMode,
  Post originalPost,
) {
  Post submittedPost = Post.fromData(text, images);
  if (currentMode == ScreenMode.ADD) {
    _submitNewPost(
      submittedPost,
      context,
      postIndex,
      currentMode,
    );
  } else {
    _submitEditedPost(
      submittedPost,
      context,
      postIndex,
      currentMode,
      originalPost,
    );
  }
}

_submitNewPost(
  Post post,
  BuildContext context,
  int postIndex,
  ScreenMode currentMode,
) {
  if (_isNewPostValid(post)) {
    NewsFeed feedProvider = Provider.of<NewsFeed>(context, listen: false);
    feedProvider.add(
      post,
      postIndex,
      successCb: () => Navigator.pop(context),
    );
  } else {
    _displayMessage(kValidationMessage[currentMode.toString()], context);
  }
}

_submitEditedPost(
  Post post,
  BuildContext context,
  int postIndex,
  ScreenMode currentMode,
  Post originalPost,
) {
  if (isPostEdited(post, originalPost)) {
    NewsFeed feedProvider = Provider.of<NewsFeed>(context, listen: false);
    feedProvider.replace(
      post,
      postIndex,
      successCb: () => Navigator.pop(context),
    );
  } else {
    _displayMessage(kValidationMessage[currentMode.toString()], context);
  }
}

bool _isNewPostValid(Post post) {
  if (post.caption == null && post.appImages.isEmpty)
    return false;
  else
    return true;
}

bool isPostEdited(Post post, Post originalPost) {
  if (post == originalPost) // '==' operator is overloaded in  Post model
    return false;
  else
    return true;
}

_displayMessage(String message, BuildContext context) {
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
}
