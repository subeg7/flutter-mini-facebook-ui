import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/widgets/app_image_widget.dart';
import 'package:flutter/material.dart';

class GridImage extends StatelessWidget {
  final List<AppImageModel> appImages;
  const GridImage({Key key, this.appImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      child: _suitableLayout(appImages, context),
    );
  }

  _suitableLayout(imgs, context) {
    switch (imgs.length) {
      case 1:
        return AppImageWidget(imgs[0]);
      case 2:
        return _buildDoubleLayout(imgs);
      case 3:
        return _buildTripleLayout(imgs);
      default:
        return _buildMultipleLayouts(imgs);
    }
  }

  _buildDoubleLayout(imgs, {hasMore = false}) {
    return Row(
      children: [
        Expanded(
          child: AppImageWidget(imgs[0]),
        ),
        Expanded(
          child: AppImageWidget(imgs[1], hasMore: hasMore),
        ),
      ],
    );
  }

  _buildTripleLayout(imgs) {
    return Container(
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: AppImageWidget(imgs[1]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: AppImageWidget(imgs[1]),
                ),
                Expanded(
                  child: AppImageWidget(imgs[2]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildMultipleLayouts(imgs) {
    return Column(children: [
      _buildDoubleLayout([imgs[0], imgs[1]]),
      _buildDoubleLayout([imgs[2], imgs[3]], hasMore: imgs.length > 4)
    ]);
  }
}
