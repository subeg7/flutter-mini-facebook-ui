import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int digit;

  const Indicator({Key key, this.digit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          "${digit + 1}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
