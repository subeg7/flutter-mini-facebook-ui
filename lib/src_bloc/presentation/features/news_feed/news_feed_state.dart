import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NewsFeedState {
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

  NewsFeedFetchSuccessState(this.posts);
}

@immutable
class NewsFeedFetchInitailState extends NewsFeedState {
  final List<Post> posts = [];
  final String message = "Press Fetch button below";
}
