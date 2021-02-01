// News Feed Screen Bloc Events
import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CreatePostEvent {}

@immutable
class VerifyNewPostEvent extends CreatePostEvent {
  final Post post;
  VerifyNewPostEvent({this.post});
}

class SubmitVerifiedNewPost extends CreatePostEvent {
  final Post post;
  SubmitVerifiedNewPost({this.post});
}

class DispatchCreatePostSubmitSuccessEvent extends CreatePostEvent {
  final Post post;

  DispatchCreatePostSubmitSuccessEvent(this.post);
}
