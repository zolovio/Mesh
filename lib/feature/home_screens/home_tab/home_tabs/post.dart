import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/controller/post_like_controller.dart';
import 'package:mesh/controller/questions_controller.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/post_model.dart';
import 'package:mesh/screens/user_info_screen.dart';
import 'package:mesh/widgets/post_widget.dart';
import 'package:mesh/widgets/video_player/mock_data.dart';
import 'package:mesh/widgets/video_player/play_video.dart';

class Post extends StatelessWidget {
  Post({Key? key, this.question = false}) : super(key: key);
  final bool question;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (kDebugMode) {
          print(controller.postsList.length);
        }
        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              )
            : controller.postsList.isEmpty
                ? Center(
                    child: Text('No Post Available'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (question) ? 4 : controller.postsList.length,
                    itemBuilder: (ctx, i) {
                      return _Post(
                        question: question,
                        postdata: controller.postsList[i],
                      );
                    },
                  );
      },
    );
  }
}

class _Post extends StatefulWidget {
  const _Post({
    Key? key,
    required this.question,
    this.postdata,
  }) : super(key: key);

  final bool question;
  final PostModel? postdata;

  @override
  State<_Post> createState() => _PostStatee();
}

class _PostStatee extends State<_Post> {
  bool isPressed = false;
  final controller = Get.find<HomeController>();

  final postController = Get.put(PostLikeController());
  final dataController = Get.put(DataController());
  late String likeCount;
  bool isLoading = false;

  @override
  void initState() {
    postLikeCount();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  postLikeCount() async {
    isLoading = true;
    String? count = await postController.getLikesCount(widget.postdata!.id);

    setState(() {
      likeCount = count!;
      ;
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // dataController.getQuestionLikesById("fc3ad83a-34c4-496f-b2e5-45735908dd31");
    postController.postCommentedByUser(widget.postdata!.id);

    return isLoading
        ? Container()
        : Container(
            // width: screenWidth * 0.8,
            margin:
                const EdgeInsets.only(top: 3, bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  color: Colors.white,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              controller.pages[0] = const UserInfoScreen();
                            },
                            child: PostTitle(
                              user: widget.postdata?.userCreated,
                              datecreated: widget.postdata?.dateCreated,
                            )),
                        //post image
                        if (!widget.question)
                          Flexible(
                            fit: FlexFit.loose,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: FeedPlayer(items: mockData["items"][0])
                                // Image.asset(
                                //   "assets/images/video.jpg",
                                //   width: double.infinity,
                                //   height: 254,
                                //   fit: BoxFit.fill,
                                // ),
                                ),
                          ),
                        if (widget.question)
                          _PostDetails(
                            screenWidth: screenWidth,
                            hashtags: [],
                            posttitle: '',
                            onTap: () {
                              setState(() {
                                isPressed = !isPressed;
                              });
                            },
                            question: widget.question,
                            onPressed: isPressed,
                            postId: widget.postdata!.id,
                            postController: postController,
                            likeCount: likeCount,
                            postLike: postController.userLikedPostsList.value
                                .contains(widget.postdata!.id),
                          ),
                      ]),
                ),
                const SizedBox(height: 15),
                if (!widget.question)
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xffF1F1F1),
                        border: Border.all(color: const Color(0xffE7E6E6)),
                        borderRadius: BorderRadius.circular(10)),
                    child: _PostDetails(
                      hashtags: widget.postdata!.tags,
                      posttitle: widget.postdata!.body.toString(),
                      question: widget.question,
                      screenWidth: screenWidth,
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      },
                      onPressed: isPressed,
                      postId: widget.postdata!.id,
                      postController: postController,
                      likeCount: likeCount,
                      postLike: postController.userLikedPostsList.value
                          .contains(widget.postdata!.id),
                    ),
                  ),
              ],
            ),
          );
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails(
      {Key? key,
      required this.screenWidth,
      required this.onTap,
      required this.question,
      required this.posttitle,
      required this.hashtags,
      this.mentioneduser = ' BishenPonnanna',
      required this.onPressed,
      required this.postId,
      required this.postLike,
      required this.postController,
      required this.likeCount})
      : super(key: key);

  final double screenWidth;
  final void Function()? onTap;
  final bool onPressed;
  final bool question;
  final String posttitle;
  final String mentioneduser;
  final List hashtags;
  final String postId;
  final bool postLike;
  final PostLikeController postController;
  final String likeCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // post icons
        (question)
            ? PostCaption(
                tags: this.hashtags,
                screenWidth: screenWidth,
                text:
                    "Another upcoming game strom.be ready urban city.Darklight Back 😍")
            : Padding(
                padding: const EdgeInsets.only(
                    bottom: 3, left: 13, right: 16, top: 13),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        if (!postController.postLike.value) {
                          postController.postLike.value =
                              await postController.likeAPost(postId);

                          print(postId);
                          postController.getLikesCount(postId);
                        } else {
                          List<Errors>? postUnlike =
                              await postController.unlikeAPost(postId);
                          String? errorMessage = postUnlike!.first.message;

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(errorMessage!),
                          ));
                        }
                      },
                      child: _PostIcon(
                          image: postLike
                              ? postController.postLike.value == true
                                  ? "assets/images/post-liked.png"
                                  : "assets/images/post-unliked.png"
                              : "assets/images/post-unliked.png",
                          text: postController.postLike.value == true
                              ? (int.parse(postController.like_count.value) + 1)
                                  .toString()
                              : likeCount),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        postController.postId.value = postId;
                        print(postController.postId.value);
                        Get.toNamed(AppRouter.commentScreen, arguments: postId);
                      },
                      child: const _PostIcon(
                          image: "assets/images/comment.png", text: "5"),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    const _PostIcon(
                        image: "assets/images/share.png", text: "Share"),
                    const Spacer(),
                    GestureDetector(
                        onTap: onTap,
                        child: _PostIcon(
                            image: (onPressed)
                                ? "assets/images/saved.png"
                                : "assets/images/save.png",
                            text: ""))
                  ],
                ),
              ),
        (question)
            ? Padding(
                padding: const EdgeInsets.only(
                    bottom: 13, left: 13, right: 16, top: 10),
                child: Row(
                  children: <Widget>[
                    const _PostIcon(
                        image: "assets/images/post-liked.png", text: "200"),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    const _PostIcon(
                        image: "assets/images/comment.png", text: "5"),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    const _PostIcon(
                        image: "assets/images/share.png", text: "Share"),
                    const Spacer(),
                    GestureDetector(
                        onTap: onTap,
                        child: _PostIcon(
                            image: (onPressed)
                                ? "assets/images/saved.png"
                                : "assets/images/save.png",
                            text: ""))
                  ],
                ),
              )
            : PostCaption(
                tags: this.hashtags,
                user: this.mentioneduser,
                screenWidth: screenWidth,
                text: this.posttitle),

        // PostDate(
        //   screenWidth: screenWidth,
        //   startDate: "18-98-990",
        //   endDate: "djewi ewjfewb",
        // )
      ],
    );
  }
}

class _PostIcon extends StatelessWidget {
  const _PostIcon({Key? key, required this.image, required this.text})
      : super(key: key);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 20,
          width: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(text,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff252529)))
      ],
    );
  }
}

// Positioned(
//                     top: 2,
//                     right: 2,
//                     child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: const Color(0xffC9C9C9).withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(15)),
//                         width: 34,
//                         height: 16,
//                         child: const FlickLeftDuration()))
