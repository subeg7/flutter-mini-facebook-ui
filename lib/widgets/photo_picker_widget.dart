import 'dart:typed_data';

import 'package:facebook/models/models.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostPhotoPicker extends StatelessWidget {
  final String label;
  final Function onImagesSubmit;

  const PostPhotoPicker({Key key, this.label, this.onImagesSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.white,
      child: FlatButton.icon(
        label: Text(
          label,
        ),
        icon: Icon(
          Icons.add_a_photo,
          size: 40.0,
          color: Colors.blue,
        ),
        onPressed: loadAssets,
        // child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print("error has occured");
    }
    List newAppImages = await Future.wait(
      resultList
          .map<Future<AppImageModel>>(
            (asset) async => await _assetToAppImage(asset),
          )
          .toList(),
    );
    onImagesSubmit(newAppImages);
  }

  Future<AppImageModel> _assetToAppImage(asset) async {
    ByteData byteData = await asset.getByteData();
    Uint8List imageData = byteData.buffer.asUint8List();
    return AppImageModel.fromLocal(imageData);
  }
}
