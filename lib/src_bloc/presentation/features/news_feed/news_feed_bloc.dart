import 'package:bloc/bloc.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/repositories/Repository.dart';

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
    // dispatch addverified post event;
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
        yield NewsFeedFetchSuccessState(
          posts: [...currentState.posts, ...newPosts],
          page: nextPage,
          hasReachedMax: hasReachedMax,
        );
      } else {
        // means fetching page for the first time
        yield NewsFeedFetchLoadingState();
        final newPosts = await _repository.fetchByPage(nextPage);
        yield NewsFeedFetchSuccessState(
          posts: [...newPosts],
          page: nextPage,
          hasReachedMax: hasReachedMax,
        );
      }
    } else if (event is NewsFeedFetchSuccessState) {
    } else if (event is NewsFeedFetchErrorState) {
    } else
      throw UnimplementedError();
  }
}

final NewsFeedBloc newsFeedBloc = NewsFeedBloc(NewsFeedEmptyState());
