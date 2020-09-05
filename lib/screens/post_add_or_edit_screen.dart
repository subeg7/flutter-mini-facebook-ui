import 'package:facebook/helpers/post_helper.dart';
import 'package:facebook/widgets/photo_picker_widget.dart';
import 'package:facebook/widgets/text_area_widget.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

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

  List<AppImageModel> postImages;
  List<Asset> assetImages = List<Asset>();

  @override
  void initState() {
    super.initState();
    postImages = List<AppImageModel>.generate(
        widget.post.appImages.length, (index) => widget.post.appImages[index]);
    textController.text = widget.post.caption;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Builder(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            Post editingPost = Post.fromData(textController.text, postImages);
            if (!isPostEdited(editingPost, widget.post))
              return true; //if post has not been changed then allow to pop
            else
              return await showPopDialog(context) ?? false;
          },
          child: SafeArea(
            child: CustomScrollView(
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
                        EditHeader(
                          indicator: widget.index,
                          mode: widget.mode,
                          image: widget.post.user.profileImage,
                          title: widget.post.user.name,
                          onSumbit: () => _handleSubmit(context),
                        ),
                        SizedBox(height: 10),
                        PostTextArea(controller: textController),
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
                        PostPhotoPicker(
                          label: postImages.isEmpty ? "Add Photos" : "Add More",
                          onImagesSubmit: _handleImages,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleImages(List<AppImageModel> imgs) {
    if (!mounted) return;
    setState(() {
      setState(() {
        postImages = [...postImages, ...imgs];
      });
    });
  }

  _handleSubmit(BuildContext context) {
    submitByScreenMode(
      textController.text,
      postImages,
      context,
      widget.index,
      widget.mode,
      widget.post,
    );
  }
}
