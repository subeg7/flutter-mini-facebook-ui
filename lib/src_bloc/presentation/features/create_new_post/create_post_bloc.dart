import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/src_bloc/presentation/features/create_new_post/create_post_event.dart';
import 'package:facebook/src_bloc/presentation/features/create_new_post/create_post_state.dart';
import 'package:facebook/src_bloc/presentation/features/news_feed/news_feed_bloc.dart';
import 'package:facebook/src_bloc/presentation/features/news_feed/news_feed_state.dart';

import '../../../../constants.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc(CreatePostState initialState) : super(initialState);

  @override
  Stream<CreatePostState> mapEventToState(CreatePostEvent event) async* {
    if (event is VerifyNewPostEvent) {
      final bool isValid = _isNewPostValid(event.post);
      if (isValid) {
        yield CreatePostValidationState(
          isValid: true,
          post: event.post,
        );
      } else {
        yield CreatePostValidationState(
          errorMessage: addValidationMessage,
          isValid: false,
          post: state.post,
        );
      }
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
