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
  final int index;

  const AddOrEditScreen({this.post, this.mode, this.index});

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
    Post tempCopy = Post.fromMap(widget.post.toMap());
    postImages = tempCopy.appImages;
    textController.text = widget.post.caption;
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
                        postImages.isNotEmpty
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
              style: AppTextStyle.title(context),
            ),
          ),
          Card(
            child: FlatButton.icon(
              label: Text(
                kSubmitButtonTitle[widget.mode.toString()],
              ),
              icon: Icon(
                kSubmitIconData[widget.mode.toString()],
                color: Colors.blue,
              ),
              onPressed: () {
                _submitByScreenMode(
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

  _submitByScreenMode(
      String text, List<AppImageModel> images, BuildContext context) {
    Post submittedPost = Post.fromData(text, images);
    if (widget.mode == ScreenMode.ADD) {
      _submitNewPost(submittedPost, context);
    } else {
      _submitEditedPost(submittedPost, context);
    }
  }

  _submitNewPost(Post post, BuildContext context) {
    if (_isNewPostValid(post)) {
      NewsFeed feedProvider = Provider.of<NewsFeed>(context, listen: false);
      feedProvider.add(
        post,
        widget.index,
        successCb: () => Navigator.pop(context),
      );
    } else {
      _displayMessage(kValidationMessage[widget.mode.toString()], context);
    }
  }

  _submitEditedPost(Post post, BuildContext context) {
    if (_isEditedPostValid(post)) {
      NewsFeed feedProvider = Provider.of<NewsFeed>(context, listen: false);
      feedProvider.replace(
        post,
        widget.index,
        successCb: () => Navigator.pop(context),
      );
    } else {
      _displayMessage(kValidationMessage[widget.mode.toString()], context);
    }
  }

  bool _isNewPostValid(Post post) {
    if (post.caption == null && post.appImages.isEmpty)
      return false;
    else
      return true;
  }

  bool _isEditedPostValid(Post post) {
    if (post == widget.post)
      return false;
    else
      return true;
  }

  _displayMessage(String message, BuildContext context) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
  }

  _buildTextArea() {
    return Container(
      color: Colors.white,
      child: TextField(
        controller: textController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "What's on your mind ...",
          labelStyle: TextStyle(
            fontSize: 14,
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
          postImages.isEmpty ? "Add Photos" : "Add More",
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

  @override
  void dispose() {
    super.dispose();
  }
}
