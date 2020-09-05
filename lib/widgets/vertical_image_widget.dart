import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';

class VerticalImageContainer extends StatelessWidget {
  final bool isCancelVisible;
  final List<AppImageModel> appImages;

  const VerticalImageContainer(this.appImages,
      {Key key, this.isCancelVisible = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: appImages
            .map(
              (img) => Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: AppImageWidget(img),
                  ),
                  Positioned(
                    right: 0.0,
                    top: 5.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
