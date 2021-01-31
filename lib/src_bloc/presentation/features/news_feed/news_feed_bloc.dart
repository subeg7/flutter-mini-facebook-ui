import 'package:bloc/bloc.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/repositories/Repository.dart';
import 'package:facebook/src_bloc/presentation/features/post/create_new_post/create_post_bloc.dart';
import 'package:facebook/src_bloc/presentation/features/post/create_new_post/create_post_event.dart';

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

  @override
  Stream<NewsFeedState> mapEventToState(NewsFeedEvent event) async* {
    final NewsFeedState currentState = state;
    final int nextPage = currentState.page + 1;
    final hasReachedMax = nextPage >= kPageLimit;

    if (event is FetchNextPage) {
      if (nextPage != 1) {
        final newPosts = await _repository.fetchByPage(nextPage);
        // means fetch is done for pagination
        yield NewsFeedUpdateSuccessState(
          posts: [...currentState.posts, ...newPosts],
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
      List<Post> allPosts = currentState.posts;
      allPosts.insert(0, event.post);
      yield NewsFeedUpdateSuccessState(
        posts: allPosts,
        page: nextPage,
        hasReachedMax: state.hasReachedMax,
      );
      createPostBloc.add(DispatchCreatePostSubmitSuccessEvent(event.post));
    } else
      throw UnimplementedError();
  }
}

final NewsFeedBloc newsFeedBloc = NewsFeedBloc(NewsFeedEmptyState());
