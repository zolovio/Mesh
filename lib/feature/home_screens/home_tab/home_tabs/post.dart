import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/post_model.dart';
import 'package:mesh/feature/home_screens/models/questions_model.dart';
import 'package:mesh/feature/home_screens/services/remote_home_services.dart';
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
          // print(controller.postsList.length);
          // print(controller.questionsList.length);
          // print(controller.postLCList.length);
          // print(controller.postLCList);
          // print(controller.quesLCList.length);
          // print(controller.userLikedPostsList.length);
        }

        return controller.isLoading.value && (controller.postsList.isEmpty || controller.questionsList.isEmpty)
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
                    itemCount: (question) ? controller.questionsList.length : controller.postsList.length,
                    itemBuilder: (ctx, i) {
                      return _Post(
                        index: i,
                        question: question,
                        postdata: question
                            ? PostModel(
                                id: '',
                                status: '',
                                dateCreated: DateTime.now(),
                                userUpdated: '',
                                dateUpdated: DateTime.now(),
                                body: "",
                                tags: [],
                                file: "",
                                type: "",
                                userCreated: null,
                                likesCount: '',
                                commentsCount: '',
                                isLikedByUser: false,
                                isCommentedByUser: false,
                                isSavedByUser: false,
                              )
                            : controller.postsList[i],
                        questionsData: question ? controller.questionsList[i] : Question(),
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
    required this.index,
    required this.question,
    this.postdata,
    required this.questionsData,
  }) : super(key: key);

  final int index;
  final bool question;
  final PostModel? postdata;
  final Question questionsData;

  @override
  State<_Post> createState() => _PostStatee();
}

class _PostStatee extends State<_Post> {
  bool isPressed = false;
  final controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    RemoteHomeServices.fetchMediaFile(widget.postdata!.id);

    return Container(
      // width: screenWidth * 0.8,
      margin: const EdgeInsets.only(top: 3, bottom: 10, left: 10, right: 10),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    ),
                  ),
                  //post image
                  if (!widget.question)
                    Flexible(
                      fit: FlexFit.loose,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
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
                      postTitle: '',
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      },
                      questionId: widget.questionsData.id!,
                      question: widget.question,
                      onPressed: isPressed,
                      postId: widget.postdata!.id,
                      controller: controller,
                      likeCount: widget.postdata!.likesCount,
                      postLike: controller.userLikedPostsList.contains(widget.postdata!.id),
                      questionText: widget.questionsData.body!,
                      isLikedByUser: widget.postdata!.isLikedByUser,
                      index: widget.index,
                    ),
                ]),
          ),
          const SizedBox(height: 15),
          if (!widget.question)
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: const Color(0xffF1F1F1), border: Border.all(color: const Color(0xffE7E6E6)), borderRadius: BorderRadius.circular(10)),
              child: _PostDetails(
                hashtags: widget.postdata!.tags,
                postTitle: widget.postdata!.body.toString(),
                questionId: "",
                question: widget.question,
                screenWidth: screenWidth,
                onTap: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                },
                onPressed: isPressed,
                postId: widget.postdata!.id,
                controller: controller,
                likeCount: widget.postdata!.likesCount,
                postLike: controller.userLikedPostsList.contains(widget.postdata!.id),
                questionText: widget.question ? widget.questionsData.body! : "",
                isLikedByUser: widget.postdata!.isLikedByUser,
                index: widget.index,
              ),
            ),
        ],
      ),
    );
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails({
    Key? key,
    required this.screenWidth,
    required this.onTap,
    required this.question,
    required this.postTitle,
    required this.hashtags,
    this.mentionedUser = ' BishenPonnanna',
    required this.onPressed,
    required this.postId,
    required this.postLike,
    required this.controller,
    required this.likeCount,
    required this.questionId,
    required this.questionText,
    required this.isLikedByUser,
    required this.index,
  }) : super(key: key);

  final double screenWidth;
  final void Function()? onTap;
  final bool onPressed;
  final bool question;
  final String postTitle;
  final String mentionedUser;
  final List hashtags;
  final String postId;
  final bool postLike;
  final HomeController controller;
  final String likeCount;
  final String questionId;
  final String questionText;
  final bool isLikedByUser;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // post icons
        (question)
            ? PostCaption(
                tags: this.hashtags,
                screenWidth: screenWidth,
                text: questionText,
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 3, left: 13, right: 16, top: 13),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        // if (isLikedByUser) {
                        //   List<Errors>? postUnlike = await controller.unlikeAPost(postId);
                        //   String? errorMessage = postUnlike!.first.message;
                        // } else {
                        //   await controller.likeAPost(postId, index);
                        //
                        //   controller.getLikesCount(postId);
                        // }
                      },
                      child: _PostIcon(
                          image: isLikedByUser ? "assets/images/post-liked.png" : "assets/images/post-unliked.png",
                          text:
                              // isLikedByUser
                              //     ? (int.parse(controller.like_count.value) + 1)
                              //         .toString()
                              //     :
                              likeCount),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.postId.value = postId;
                        Get.toNamed(AppRouter.commentScreen, arguments: postId);
                      },
                      child: const _PostIcon(image: "assets/images/comment.png", text: "5"),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    const _PostIcon(image: "assets/images/share.png", text: "Share"),
                    const Spacer(),
                    GestureDetector(
                        onTap: onTap, child: _PostIcon(image: (onPressed) ? "assets/images/saved.png" : "assets/images/save.png", text: ""))
                  ],
                ),
              ),
        (question)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 13, left: 13, right: 16, top: 10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        if (isLikedByUser) {
                          List<Errors>? postUnlike = await controller.unlikeAQuestion(questionId);
                          String? errorMessage = postUnlike!.first.message;
                        } else {
                          await controller.likeAQuestion(questionId, index);

                          controller.getLikeCountByQuestionId(questionId);
                        }
                      },
                      child: _PostIcon(image: isLikedByUser ? "assets/images/post-liked.png" : "assets/images/post-unliked.png", text: likeCount),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    const _PostIcon(image: "assets/images/comment.png", text: "5"),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    const _PostIcon(image: "assets/images/share.png", text: "Share"),
                    const Spacer(),
                    GestureDetector(
                        onTap: onTap, child: _PostIcon(image: (onPressed) ? "assets/images/saved.png" : "assets/images/save.png", text: ""))
                  ],
                ),
              )
            : PostCaption(tags: this.hashtags, user: this.mentionedUser, screenWidth: screenWidth, text: this.postTitle),

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
  const _PostIcon({Key? key, required this.image, required this.text}) : super(key: key);

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
        Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff252529)))
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
