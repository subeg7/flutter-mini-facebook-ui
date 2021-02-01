import 'package:flutter/material.dart';

import 'package:facebook/models/post_model.dart';

@immutable
abstract class NewsFeedState {
  List<Post> posts = [];
  int page;
  bool hasReachedMax;
  NewsFeedState({
    this.posts,
    this.page = 0,
    this.hasReachedMax = false,
  });
}

@immutable
class NewsFeedFetchErrorState extends NewsFeedState {
  final Exception error;

  NewsFeedFetchErrorState(this.error);
}

@immutable
class NewsFeedFetchLoadingState extends NewsFeedState {}

@immutable
class NewsFeedUpdateSuccessState extends NewsFeedState {
  final List<Post> posts;
  final int page;
  final bool hasReachedMax;

  NewsFeedUpdateSuccessState({this.posts, this.page, this.hasReachedMax});
}

@immutable
class NewsFeedEmptyState extends NewsFeedState {
  final String message = "Press Fetch button below";
}
