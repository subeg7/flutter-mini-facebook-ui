import 'package:facebook/models/app_image_model.dart';
import 'package:flutter/material.dart';

class AppImageWidget extends StatelessWidget {
  final bool hasMore;
  final AppImageModel appImage;

  const AppImageWidget(this.appImage, {Key key, this.hasMore = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          appImage.type == AppImageType.Network
              ? Image.network(
                  appImage.url,
                  fit: BoxFit.cover,
                )
              : Image.memory(
                  appImage.path,
                  fit: BoxFit.cover,
                ),
          hasMore
              ? Container(
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: Text(
                      "More",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ))
              : SizedBox(),
        ],
      ),
    );
  }
}
