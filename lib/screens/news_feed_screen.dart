import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen>
    with AfterLayoutMixin<NewsFeedScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    // fetch the inital posts to render
    Provider.of<NewsFeed>(context, listen: false).fetchPost();
    //TODO :: show the snackbar ??
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Consumer<NewsFeed>(
          builder: (BuildContext context, NewsFeed newsFeedProvider, child) {
            if(newsFeedProvider.isLoading)
              return Center(child : CircularProgressIndicator());
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text("My Facebook"),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    newsFeedProvider.posts
                        .map((post) => PostCard(post: post))
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
