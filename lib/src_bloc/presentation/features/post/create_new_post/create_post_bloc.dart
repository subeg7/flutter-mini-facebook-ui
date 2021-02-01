import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/src_bloc/presentation/features/news_feed/news_feed_bloc.dart';
import 'package:facebook/src_bloc/presentation/features/post/common/post_common.dart';

import '../../../../../constants.dart';
import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc(CreatePostState initialState) : super(initialState);

  @override
  Stream<CreatePostState> mapEventToState(CreatePostEvent event) async* {
    if (event is VerifyNewPostEvent) {
      final bool isValid = _isNewPostValid(event.post);
      PostValidation validation;
      if (isValid) {
        validation = PostValidation(event.post, true);
      } else {
        validation = PostValidation(event.post, false,
            errorMessage: addValidationMessage);
      }
      yield CreatePostValidationState(validation);
    } else if (event is SubmitVerifiedNewPost) {
      newsFeedBloc.addPost(event.post);
    } else if (event is DispatchCreatePostSubmitSuccessEvent) {
      yield SubmitedNewPostSuccessState(event.post);
    } else
      throw UnimplementedError();
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
}

final CreatePostBloc createPostBloc = CreatePostBloc(CreatePostInititalState());
