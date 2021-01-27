import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NewsFeedState {
  List<Post> posts;
  int page;

  NewsFeedState({this.posts, this.page = 0});
}

@immutable
class NewsFeedFetchErrorState extends NewsFeedState {
  final Exception error;

  NewsFeedFetchErrorState(this.error);
}

@immutable
class NewsFeedFetchLoadingState extends NewsFeedState {}

@immutable
class NewsFeedFetchSuccessState extends NewsFeedState {
  final List<Post> posts;
  final int page;
  final bool hasReachedMax;

  NewsFeedFetchSuccessState({this.posts, this.page, this.hasReachedMax});
}

@immutable
class NewsFeedEmptyState extends NewsFeedState {
  final String message = "Press Fetch button below";
}
