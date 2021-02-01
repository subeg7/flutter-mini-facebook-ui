import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EditPostEvent {}

class VerifyEditPostEvent extends EditPostEvent {
  final Post newPost;
  final Post originalPost;
  final int postIndex;

  VerifyEditPostEvent({this.newPost, this.originalPost, this.postIndex});
}

class SubmitVerifiedEditedPost extends EditPostEvent {
  final Post post;
  final int postIndex;

  SubmitVerifiedEditedPost({this.postIndex, this.post});
}

class DispatchEditPostSubmitSuccessEvent extends EditPostEvent {
  final Post post;
  final int postIndex;

  DispatchEditPostSubmitSuccessEvent(this.post, this.postIndex);
}
