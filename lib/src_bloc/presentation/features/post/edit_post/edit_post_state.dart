import 'package:facebook/models/post_model.dart';
import 'package:facebook/src_bloc/presentation/features/post/common/post_common.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class EditPostState {}

@immutable
class EditPostValidationState extends EditPostState {
  final PostValidation validation;
  final int postIndex;

  EditPostValidationState(this.validation, this.postIndex);
}

class SubmitedEditedPostSuccessState extends EditPostState {
  final Post post;
  final int postIndex;

  SubmitedEditedPostSuccessState(this.post, this.postIndex);
}

class SubmitedEditedPostErrorState extends EditPostState {
  final Post post;

  final Exception error;

  SubmitedEditedPostErrorState(this.post, this.error);
}

class EditPostInitialState extends EditPostState {}
