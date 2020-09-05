import 'package:flutter/material.dart';

class PostTextArea extends StatelessWidget {
  final TextEditingController controller;

  const PostTextArea({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "What's on your mind ...",
          labelStyle: TextStyle(
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
