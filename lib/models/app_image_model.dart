import 'dart:typed_data';

class AppImageModel {
  String url;
  Uint8List path;
  AppImageType type;

  AppImageModel.fromNetwork(img) {
    url = img;
    type = AppImageType.Network;
  }

  AppImageModel.fromLocal(Uint8List imgpath) {
    path = imgpath;
    type = AppImageType.Local;
  }
}

enum AppImageType { Local, Network }
