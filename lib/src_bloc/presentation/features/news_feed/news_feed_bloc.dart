import 'package:bloc/bloc.dart';
import 'package:facebook/repositories/Repository.dart';

import 'news_feed_event.dart';
import 'news_feed_state.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  NewsFeedBloc(NewsFeedState initialState) : super(initialState);
  final _repository = Repository();
  int _page = 1;
  int get page => _page;

  void fetchNextPage() {
    add(FetchNextPage());
  }

  @override
  Stream<NewsFeedState> mapEventToState(NewsFeedEvent event) async* {
    if (event is FetchNextPage) {
      yield NewsFeedFetchLoadingState();
      final newPosts = await _repository.fetchByPage(++_page);
      yield NewsFeedFetchSuccessState(newPosts);
    } else if (event is NewsFeedFetchSuccessState) {
    } else if (event is NewsFeedFetchErrorState) {
    } else
      throw UnimplementedError();
  }
}

final NewsFeedBloc newsFeedBloc = NewsFeedBloc(NewsFeedFetchInitailState());
