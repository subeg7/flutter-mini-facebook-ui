// News Feed Screen Bloc Events
import 'package:flutter/material.dart';

@immutable
abstract class NewsFeedEvent {}

@immutable
class FetchNextPage extends NewsFeedEvent {}