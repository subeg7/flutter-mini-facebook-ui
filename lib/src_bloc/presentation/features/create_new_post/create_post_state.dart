import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

@immutable
abstract class CreatePostState {
  Post post;
}

@immutable
class CreatePostValidationState extends CreatePostState {
  final String errorMessage;
  final Post post;
  final bool isValid;

  CreatePostValidationState({this.errorMessage, this.post, this.isValid});
}

class SubmitedNewPostSuccessState extends CreatePostState {
  final Post post;

  SubmitedNewPostSuccessState(this.post);
}

class SubmitedNewPostErrorState extends CreatePostState {
  final Post post;
  final Exception error;

  SubmitedNewPostErrorState(this.post, this.error);
}

class CreatePostInititalState extends CreatePostState {}
