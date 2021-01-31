import 'package:facebook/models/post_model.dart';
import 'package:flutter/material.dart';

@immutable
class PostValidation {
  final String errorMessage;
  final Post post;
  final bool isValid;

  PostValidation(
    this.post,
    this.isValid, {
    this.errorMessage,
  });
}


