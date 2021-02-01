import 'package:bloc/bloc.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/repositories/Repository.dart';
import 'package:facebook/src_bloc/presentation/features/post/create_new_post/create_post_bloc.dart';
import 'package:facebook/src_bloc/presentation/features/post/create_new_post/create_post_event.dart';
import 'package:facebook/src_bloc/presentation/features/post/edit_post/edit_post_bloc.dart';
import 'package:facebook/src_bloc/presentation/features/post/edit_post/edit_post_event.dart';

import '../../../../constants.dart';
import 'news_feed_event.dart';
import 'news_feed_state.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  NewsFeedBloc(NewsFeedState initialState) : super(initialState);
  final _repository = Repository();

  void fetchNextPage() {
    add(FetchNextPage());
  }

  void addPost(Post post) {
    add(AddVerifiedPost(post));
  }

  void addReplacePostEvent(Post post, int postIndex) {
    add(EditPostByIndex(post, postIndex));
  }

  @override
  Stream<NewsFeedState> mapEventToState(NewsFeedEvent event) async* {
    if (event is FetchNextPage) {
      final int nextPage = state.page + 1;
      final hasReachedMax = nextPage >= kPageLimit;
      if (nextPage != 1) {
        final newPosts = await _repository.fetchByPage(nextPage);
        // means fetch is done for pagination
        yield NewsFeedUpdateSuccessState(
          posts: [...state.posts, ...newPosts],
          page: nextPage,
          hasReachedMax: hasReachedMax,
        );
      } else {
        // means fetching page for the first time
        yield NewsFeedFetchLoadingState();
        final newPosts = await _repository.fetchByPage(nextPage);
        yield NewsFeedUpdateSuccessState(
          posts: [...newPosts],
          page: nextPage,
          hasReachedMax: hasReachedMax,
        );
      }
    } else if (event is AddVerifiedPost) {
      List<Post> allPosts = state.posts;
      allPosts.insert(0, event.post);
      yield NewsFeedUpdateSuccessState(
        // this updates news feed screen
        posts: allPosts,
        page: state.page,
        hasReachedMax: state.hasReachedMax,
      );
      //this updates the create post screen
      createPostBloc.add(DispatchCreatePostSubmitSuccessEvent(event.post));
    } else if (event is EditPostByIndex) {
      int startIndex = event.postIndex;
      int endIndex = startIndex + 1;
      List<Post> allPosts = state.posts;

      allPosts.replaceRange(startIndex, endIndex,
          [event.post]); //start is inclusive but end is exclusive
      yield NewsFeedUpdateSuccessState(
        // this updates news feed screen
        posts: allPosts,
        page: state.page,
        hasReachedMax: state.hasReachedMax,
      );
      //this updates the create post screen
      editPostBloc
          .add(DispatchEditPostSubmitSuccessEvent(event.post, event.postIndex));
    } else
      throw UnimplementedError();
  }
}

final NewsFeedBloc newsFeedBloc = NewsFeedBloc(NewsFeedEmptyState());
