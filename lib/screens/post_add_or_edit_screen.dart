import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';

import '../main.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddOrEditScreen extends StatefulWidget {
  final Post post;
  final ScreenMode mode;
  const AddOrEditScreen({Key key, this.post, this.mode}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AddOrEditScreenState();
}

class _AddOrEditScreenState extends State<AddOrEditScreen> {
  TextEditingController textController = new TextEditingController();

  List<AppImageModel> postImages = [];
  List<Asset> assetImages = List<Asset>();

  @override
  void initState() {
    super.initState();
    textController.text = widget.post.caption;
    postImages = widget.post.appImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Consumer<NewsFeed>(
          builder: (BuildContext context, NewsFeed newsFeedProvider, child) {
            if (newsFeedProvider.isLoading)
              return Center(child: CircularProgressIndicator());
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(
                    kScreenModeTitleMap[widget.mode.toString()].toUpperCase() +
                        " post".toUpperCase(),
                  ),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        SizedBox(height: 10),
                        _buildTextArea(),
                        widget.post.appImages.isNotEmpty
                            ? Container(
                                color: Colors.white,
                                child: VerticalImageContainer(postImages,
                                    isCancelVisible: true,
                                    onCancelPress: (int imageAT) =>
                                        setState(() {
                                          postImages.removeAt(imageAT);
                                        })),
                              )
                            : SizedBox(),
                        _buildImagePicker(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          ProfileAvatar(
            image: widget.post.user.profileImage,
            radius: 25.0,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.post.user.name,
              style: AppTextStyle.userName(context),
            ),
          ),
          Card(
            child: FlatButton.icon(
              label: Text(
                "Save",
              ),
              icon: Icon(
                Icons.check,
                color: Colors.blue,
              ),
              onPressed: () {
                _handleSaveButtonClick(
                  textController.text,
                  postImages,
                  context,
                );
              },
              // child: Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }

  _handleSaveButtonClick(
      String text, List<AppImageModel> images, BuildContext context) {
    Post editedPost = new Post.edited(text, images);
    if (editedPost == widget.post) {
      //the '==' operator has been overloaded in model
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text("First change something to save"),
        ));
    } else {
      print("its saveable");
    }
  }

  _buildTextArea() {
    return Container(
      color: Colors.white,
      child: TextField(
        controller: textController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "What's on your mind ...", //TODO :: make it dynamic
          labelStyle: TextStyle(
            fontSize: 14, //TODO :: make it global
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

  _buildImagePicker() {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.white,
      child: FlatButton.icon(
        label: Text(
          "Add More",
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
        selectedAssets: assetImages,
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

    if (!mounted) return;
    List newAppImages = await Future.wait(
      resultList
          .map<Future<AppImageModel>>(
            (asset) async => await _assetToAppImage(asset),
          )
          .toList(),
    );
    setState(() {
      postImages = [...postImages, ...newAppImages];
    });
  }

  Future<AppImageModel> _assetToAppImage(asset) async {
    ByteData byteData = await asset.getByteData();
    Uint8List imageData = byteData.buffer.asUint8List();
    return AppImageModel.fromLocal(imageData);
  }
}
