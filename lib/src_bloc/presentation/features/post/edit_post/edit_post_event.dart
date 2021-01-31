import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EditPostEvent {}

class VerifyEditPostEvent extends EditPostEvent {
  final Post post;
  final int postIndex;

  VerifyEditPostEvent({this.postIndex, this.post});
}

class SubmitVerifiedEditedPost extends EditPostEvent {
  final Post post;
  final int postIndex;

  SubmitVerifiedEditedPost({this.postIndex, this.post});
}
