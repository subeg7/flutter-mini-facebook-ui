// News Feed Screen Bloc Events
import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NewsFeedEvent {}

@immutable
class FetchNextPage extends NewsFeedEvent {}

class AddVerifiedPost extends NewsFeedEvent {
  final Post post;
  AddVerifiedPost(this.post);
}
