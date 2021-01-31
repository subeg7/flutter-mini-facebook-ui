import 'package:facebook/src_bloc/presentation/features/news_feed/news_feed_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_feed_bloc.dart';

class BlocScreen extends StatefulWidget {
  @override
  _BlocScreenState createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: BlocProvider<NewsFeedBloc>(
          create: (context) => NewsFeedBloc(NewsFeedEmptyState()),
          child: PostsWrapper(),
        ),
      ),
    ));
  }
}

class PostsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.yellow,
            // height: MediaQuery.of(context).size.height,
            // width: double.infinity,
            child: BlocConsumer<NewsFeedBloc, NewsFeedState>(
              listener: (context, state) {
                //listener doesn't build anything
                // good for navigations and snackbar
              },
              builder: (context, state) {
                if (state is NewsFeedEmptyState)
                  return Center(child: Text(state.message));
                else if (state is NewsFeedFetchLoadingState)
                  return Center(child: CircularProgressIndicator());
                else if (state is NewsFeedUpdateSuccessState)
                  return Center(child: Text("Data has been loaded"));
                // else
                return Center(child: Text("Unimplemented state"));
              },
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              BlocProvider.of<NewsFeedBloc>(context).fetchNextPage();
            },
            child: Text("Refresh"),
          ),
        ),
      ],
    );
  }
}
