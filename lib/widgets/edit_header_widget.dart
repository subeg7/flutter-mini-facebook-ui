import 'package:facebook/constants.dart';
import 'package:facebook/main.dart';
import 'package:facebook/models/user_model.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditHeader extends StatelessWidget {
  final int indicator;
  final ScreenMode mode;
  final Function onSumbit;
  final String image;
  final String title;

  const EditHeader({
    Key key,
    this.indicator,
    this.image,
    this.title,
    this.mode,
    this.onSumbit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          ProfileAvatar(
            image: image,
            radius: 25.0,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.title(context),
            ),
          ),
          Indicator(digit: indicator),
          SizedBox(width: 5),
          Card(
            child: FlatButton.icon(
                label: Text(
                  kSubmitButtonTitle[mode.toString()],
                ),
                icon: Icon(
                  kSubmitIconData[mode.toString()],
                  color: Colors.blue,
                ),
                onPressed: onSumbit
                // child: Icon(Icons.add_a_photo),
                ),
          ),
        ],
      ),
    );
  }
}
