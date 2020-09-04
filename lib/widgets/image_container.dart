import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final List<String> images;
  const ImageContainer({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      child: _suitableLayout(images, context),
    );
  }

  _suitableLayout(imgs, context) {
    switch (imgs.length) {
      case 1:
        return _buildSingleImage(imgs[0]);
      case 2:
        return _buildDoubleImage(imgs);
      case 3:
        return _buildTripleImage(imgs);
      default:
        return _buildMultipleImages(imgs);
    }
  }

  _buildSingleImage(img, {hasMore = false}) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            img,
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

  _buildDoubleImage(imgs, {hasMore = false}) {
    return Row(
      children: [
        Expanded(
          child: _buildSingleImage(imgs[0]),
        ),
        Expanded(
          child: _buildSingleImage(imgs[1], hasMore: hasMore),
        ),
      ],
    );
  }

  _buildTripleImage(imgs) {
    return Container(
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _buildSingleImage(imgs[1]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _buildSingleImage(imgs[1]),
                ),
                Expanded(
                  child: _buildSingleImage(imgs[2]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildMultipleImages(imgs) {
    return Column(children: [
      _buildDoubleImage([imgs[0], imgs[1]]),
      _buildDoubleImage([imgs[2], imgs[3]], hasMore: imgs.length > 4)
    ]);
  }
}
