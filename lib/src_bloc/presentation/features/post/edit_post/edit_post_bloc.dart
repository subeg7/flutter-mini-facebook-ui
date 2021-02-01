import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/src_bloc/presentation/features/news_feed/news_feed_bloc.dart';
import 'package:facebook/src_bloc/presentation/features/post/common/post_common.dart';
import 'package:facebook/src_bloc/presentation/features/post/edit_post/edit_post_state.dart';

import '../../../../../constants.dart';
import 'edit_post_event.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  EditPostBloc(EditPostState initialState) : super(initialState);

  @override
  Stream<EditPostState> mapEventToState(EditPostEvent event) async* {
    if (event is VerifyEditPostEvent) {
      final bool isValid = _isPostEdited(event.newPost, event.originalPost);
      PostValidation validation;
      if (isValid) {
        validation = PostValidation(event.newPost, true);
      } else {
        validation = PostValidation(event.newPost, false,
            errorMessage: editValidationMessage);
      }
      yield EditPostValidationState(validation, event.postIndex);
    } else if (event is SubmitVerifiedEditedPost) {
      newsFeedBloc.addReplacePostEvent(event.post, event.postIndex);
    } else if (event is DispatchEditPostSubmitSuccessEvent) {
      yield SubmitedEditedPostSuccessState(event.post, event.postIndex);
    } else
      throw UnimplementedError();
  }

/*
  Edited data validator function
*/
  bool _isPostEdited(Post newPost, Post originalPost) {
    if (newPost == originalPost) // '==' operator is overloaded in  Post model
      return false;
    else
      return true;
  }
}

final EditPostBloc editPostBloc = EditPostBloc(EditPostInitialState());
