import 'package:facebook/helpers/post_helper.dart';
import 'package:facebook/widgets/photo_picker_widget.dart';
import 'package:facebook/widgets/text_area_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'create_post_bloc.dart';
import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostBlocScreen extends StatefulWidget {
  final ScreenMode mode;

  const CreatePostBlocScreen({Key key, this.mode = ScreenMode.ADD})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatePostBlocScreenState();
}

class _CreatePostBlocScreenState extends State<CreatePostBlocScreen> {
  TextEditingController textController = new TextEditingController();

  List<AppImageModel> postImages = [];
  List<Asset> assetImages = List<Asset>();

  @override
  void initState() {
    // final bloc = BlocProvider.of<CreatePostBloc>(context, listen: false);
    super.initState();
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
            child: BlocListener<CreatePostBloc, CreatePostState>(
              listener: (context, state) {
                if (state is CreatePostValidationState && state.isValid) {
                  //TODO :: discuss this should be at the bloc or here ??
                  BlocProvider.of<CreatePostBloc>(context).add(
                    SubmitVerifiedNewPost(post: state.post),
                  );
                } else if (state is CreatePostValidationState &&
                    !state.isValid) {
                  displayMessage(state.errorMessage, context);
                } else if (state is SubmitedNewPostSuccessState) {
                  //navigate to the news feed screen
                  Navigator.pop(context);
                } else if (state is SubmitedNewPostErrorState) {
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
                              BlocProvider.of<CreatePostBloc>(context)
                                  .add(VerifyNewPostEvent(post: post));
                            },
                          ),
                          SizedBox(height: 10),
                          PostTextArea(controller: textController),
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
