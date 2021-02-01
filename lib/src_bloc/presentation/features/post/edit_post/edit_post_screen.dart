import 'package:facebook/helpers/post_helper.dart';
import 'package:facebook/src_bloc/presentation/features/post/edit_post/edit_post_bloc.dart';
import 'package:facebook/src_bloc/presentation/features/post/edit_post/edit_post_state.dart';
import 'package:facebook/widgets/photo_picker_widget.dart';
import 'package:facebook/widgets/text_area_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'edit_post_event.dart';

class EditPostBlocScreen extends StatefulWidget {
  final ScreenMode mode;
  final int index;
  final Post post;

  const EditPostBlocScreen(
      {Key key, this.mode = ScreenMode.EDIT, this.index, this.post})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPostBlocScreenState();
}

class _EditPostBlocScreenState extends State<EditPostBlocScreen> {
  TextEditingController textController = new TextEditingController();

  List<AppImageModel> postImages = [];
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
            return true;
            // Post editingPost = Post.fromData(textController.text, postImages);
            // if (!isPostEdited(editingPost, widget.post))
            //   return true; //if post has not been changed then allow to pop
            // else
            //   return await showPopDialog(context) ?? false;
          },
          child: SafeArea(
            child: BlocListener<EditPostBloc, EditPostState>(
              listener: (context, state) {
                if (state is EditPostValidationState &&
                    state.validation.isValid) {
                  //TODO :: discuss this should be at the bloc or here ??
                  BlocProvider.of<EditPostBloc>(context).add(
                    SubmitVerifiedEditedPost(
                      post: state.validation.post,
                      postIndex: state.postIndex,
                    ),
                  );
                } else if (state is EditPostValidationState &&
                    !state.validation.isValid) {
                  displayMessage(state.validation.errorMessage, context);
                } else if (state is SubmitedEditedPostSuccessState) {
                  //navigate to the news feed screen
                  Navigator.pop(context);
                } else if (state is SubmitedEditedPostErrorState) {
                  displayMessage(state.error.toString(), context);
                }
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    title: Text(
                      kScreenModeTitleMap[widget.mode.toString()]
                              .toUpperCase() +
                          " post".toUpperCase(),
                      key: ValueKey("Post-add-or-edit-screen-title-text"),
                    ),
                    leading: IconButton(
                      key: ValueKey("back-button"),
                      icon: Icon(Icons.chevron_left_sharp),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
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
                            mode: widget.mode,
                            image: loggedInUser.profileImage,
                            title: loggedInUser.name,
                            onSumbit: () {
                              Post post = Post.fromData(
                                  textController.text, postImages);
                              BlocProvider.of<EditPostBloc>(context)
                                  .add(VerifyEditPostEvent(
                                newPost: post,
                                originalPost: widget.post,
                                postIndex: widget.index,
                              ));
                            },
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
                            label: "Add Photos",
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
      ),
    );
  }

  _handleImages(imgs) {
    if (!mounted) return;
    setState(() {
      postImages = [...postImages, ...imgs];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
