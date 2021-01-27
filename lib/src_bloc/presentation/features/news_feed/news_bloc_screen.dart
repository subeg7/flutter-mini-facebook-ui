import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'news_feed_bloc.dart';
import 'news_feed_state.dart';

class NewsFeedBlocScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsFeedBlocScreenState();
}

class _NewsFeedBlocScreenState extends State<NewsFeedBlocScreen>
    with AfterLayoutMixin<NewsFeedBlocScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /*
    Fetch the first of the paginated data,
    could be poerformed in initState, just showing the variants here
   */
  @override
  void afterFirstLayout(_) {
    //bloc provider call screen
    BlocProvider.of<NewsFeedBloc>(context).fetchNextPage();
  }

  /*
    Fetch more data on scroll
  */
  void _onLoading() async {
    final NewsFeedBloc bloc = BlocProvider.of<NewsFeedBloc>(context);

    // final newsFeed = context.read(newsFeedProvider);
    //  final newsFeed = ProviderReference().watch(newsFeedProvider);
    // int nextPage = bloc.page + 1;
    // await bloc.fetchNextPage();
    // page: nextPage,
    // successCb: () => _refreshController
    //     .loadComplete(), //means this page data has been loaded, allowing to scroll more
    // dataCompleteCb: () => _refreshController
    //     .loadNoData(), //_onLoading() is not triggered even if scrolled down
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: BlocConsumer<NewsFeedBloc, NewsFeedState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NewsFeedFetchLoadingState)
              return Center(child: CupertinoActivityIndicator());
            else if (state is NewsFeedFetchSuccessState)
              return SmartRefresher(
                enablePullUp: true,
                enablePullDown: false,
                controller: _refreshController,
                onLoading: _onLoading,
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                  completeDuration: Duration(milliseconds: 500),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      title: Text("My Facebook",
                          key: Key("News-feed-screen-title-text")),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: AddNewWidget(
                        profileImage: loggedInUser.profileImage,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        state.posts
                            .asMap() //asMap is used to achieve index in currenItem the list
                            .map(
                              (index, post) => MapEntry(
                                index,
                                PostCard(post: post, index: index),
                              ),
                            )
                            .values
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            else
              return Center(child: Text("Unimplemented state"));
          },
        ),
      ),
    );
  }
}