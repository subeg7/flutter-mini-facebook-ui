import 'package:facebook/constants.dart';
import 'package:facebook/models/app_image_model.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class AddOrEditScreen extends StatefulWidget {
  final Post post;
  final ScreenMode mode;
  const AddOrEditScreen({Key key, this.post, this.mode}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AddOrEditScreenState();
}

class _AddOrEditScreenState extends State<AddOrEditScreen> {
  TextEditingController textController = new TextEditingController();

  List<AppImageModel> images = [];

  @override
  void initState() {
    super.initState();
    textController.text = widget.post.caption;
    images = widget.post.appImages;
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
                        Row(
                          children: [
                            ProfileAvatar(
                              image: widget.post.user.profileImage,
                              radius: 20.0,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.post.user.name,
                                style: AppTextStyle.userName(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          color: Colors.white,
                          child: TextField(
                            // controller: textController,
                            // keyboardType: TextInputType.multiline,
                            // maxLines: null,
                            decoration: InputDecoration(
                              hintText:
                                  "What's on your mind ...", //TODO :: make it dynamic
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
                        ),
                        widget.post.appImages.isNotEmpty
                            ? Container(
                                color: Colors.white,
                                child: VerticalImageContainer(
                                  images,
                                  isCancelVisible: true,
                                ),
                              )
                            : SizedBox(),
                        Container(
                          height: 20,
                          color: Colors.white,
                        ),
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
}
