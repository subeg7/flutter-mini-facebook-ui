import 'package:facebook/models/models.dart';
import 'package:facebook/providers/change_notifier_providers.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen>
    with AfterLayoutMixin<NewsFeedScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /*
    Fetch the first of the paginated data,
    could be poerformed in initState, just showing the variants here
   */
  @override
  void afterFirstLayout(_) {
    final newsFeed = context.read(newsFeedProvider);
    newsFeed.fetchPost(
      page: 1,
      successCb: () => print("success"),
      dataCompleteCb: () => print("complete"),
    );
  }

  /*
    Fetch more data on scroll
  */
  void _onLoading() async {
    final newsFeed = context.read(newsFeedProvider);
    //  final newsFeed = ProviderReference().watch(newsFeedProvider);
    int nextPage = newsFeed.currentPage + 1;
    await newsFeed.fetchPost(
      page: nextPage,
      successCb: () => _refreshController
          .loadComplete(), //means this page data has been loaded, allowing to scroll more
      dataCompleteCb: () => _refreshController
          .loadNoData(), //_onLoading() is not triggered even if scrolled down
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Consumer(
          builder: (BuildContext context, ScopedReader watch, _) {
            final newsFeed = watch(newsFeedProvider);
            return AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: newsFeed.isFetchingPage1
                  ? Center(child: CupertinoActivityIndicator())
                  : SmartRefresher(
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
                              newsFeed.posts
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
                    ),
            );
          },
        ),
      ),
    );
  }
}
