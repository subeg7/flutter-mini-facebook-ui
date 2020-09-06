import 'package:facebook/constants.dart';
import 'package:facebook/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  showPopDialog is triggered by WillPopScope,
  it returns true if clicked on no,
  returns false if clicked on yes,
*/
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

/*
  submitByScreenMode function is the root level submit,
  first, checks if the post is to be added or edited,
  second, validates the data according to the add or edit mode,

  if everything okay,
  triggers the data change that will be displayed on NewsFeedScreen
*/
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
  // new created data validation
  if (_isNewPostValid(post)) {
    NewsFeed feedProvider = Provider.of<NewsFeed>(context, listen: false);
    feedProvider.add(
      post,
      postIndex,
      successCb: () => Navigator.pop(context),
    );
  } else {
    displayMessage(kValidationMessage[currentMode.toString()], context);
  }
}

_submitEditedPost(
  Post post,
  BuildContext context,
  int postIndex,
  ScreenMode currentMode,
  Post originalPost,
) {
  // edited data validation
  if (isPostEdited(post, originalPost)) {
    NewsFeed feedProvider = Provider.of<NewsFeed>(context, listen: false);
    feedProvider.replace(
      post,
      postIndex,
      successCb: () => Navigator.pop(context),
    );
  } else {
    displayMessage(kValidationMessage[currentMode.toString()], context);
  }
}

/*
  New data validator function
*/
bool _isNewPostValid(Post post) {
  if (post.caption == null && post.appImages.isEmpty)
    return false;
  else
    return true;
}

/*
  WARNING : isPostEdited validator function is not private,
  check is uses before editing

*/
bool isPostEdited(Post post, Post originalPost) {
  if (post == originalPost) // '==' operator is overloaded in  Post model
    return false;
  else
    return true;
}

/*
  WARNING : make sure displayMessage gets the context with the Scaffold in it,
  otherwise the snackbar won't be displayed
*/
displayMessage(String message, BuildContext context) {
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
