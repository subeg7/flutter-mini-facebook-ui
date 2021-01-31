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
      final bool isValid = _editedPostValid(event.post);
      PostValidation validation;
      if (isValid) {
        validation = PostValidation(event.post, true);
      } else {
        validation = PostValidation(event.post, false,
            errorMessage: editValidationMessage);
      }
      yield EditPostValidationState(validation, event.postIndex);
    } else if (event is SubmitVerifiedEditedPost) {
      newsFeedBloc.replacePost(event.post);
    }
    // else if (event is DispatchCreatePostSubmitSuccessEvent) {
    //   yield SubmitedNewPostSuccessState(event.post);
    // }
    else
      throw UnimplementedError();
  }

/*
  New data validator function
*/
  bool _editedPostValid(Post post) {
    return false;
    //TODO :: implement edit post logic later
    // if (post.caption == null && post.appImages.isEmpty)
    //   return false;
    // else
    //   return true;
  }
}

final EditPostBloc editPostBloc = EditPostBloc(EditPostInitialState());
