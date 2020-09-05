import 'package:facebook/constants.dart';
import 'package:facebook/main.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/routes/scale_route.dart';
import 'package:facebook/routes/slide_route.dart';
import 'package:facebook/screens/screens.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddNewWidget extends StatelessWidget {
  final String profileImage;

  const AddNewWidget({Key key, this.profileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: InkWell(
        onTap: () {
          _handleOnCardTap(context);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatar(image: profileImage, radius: 25.0),
                SizedBox(width: 50),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "What's on your mind ? ",
                      style: AppTextStyle.subTitle(context),
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleOnCardTap(BuildContext context) {
    Navigator.push(
      context,
      SlideRoute(
        page: AddOrEditScreen(
          post: Post(),
          mode: ScreenMode.ADD,
        ),
      ),
    );
  }
}
