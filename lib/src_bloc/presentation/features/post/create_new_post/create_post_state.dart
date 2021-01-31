import 'package:facebook/models/post_model.dart';
import 'package:facebook/src_bloc/presentation/features/post/common/post_common.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CreatePostState {
  Post post;
}

@immutable
class CreatePostValidationState extends CreatePostState {
  final PostValidation validation;

  CreatePostValidationState(this.validation);
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
