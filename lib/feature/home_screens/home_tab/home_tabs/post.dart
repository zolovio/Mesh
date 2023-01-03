import 'package:cached_network_image/cached_network_image.dart';
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
  Post({Key? key, this.question = false, this.isMyPosts = false, this.isMyQuestions = false, this.isBookMarks = false, s}) : super(key: key);

  final bool question;
  final bool isMyPosts;
  final bool isMyQuestions;
  final bool isBookMarks;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        print(isBookMarks);

        if (kDebugMode) {
          // print(controller.allPostsList.length);
          // print(controller.userPostsList.length);
          // print(controller.allQuestionsList.length);
          // print(controller.userQuestionsList.length);
          // print(controller.postLCList.length);
          // print(controller.postLCList);
          // print(controller.quesLCList.length);
          // print(controller.userLikedPostsList.length);
        }

        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              )
            : (isMyPosts
                    ? controller.userPostsList.isEmpty
                    : isBookMarks
                        ? controller.bookmarkPostsList.isEmpty
                        : controller.allPostsList.isEmpty)
                ? Center(
                    child: question ? Text('No Question available') : Text('No Post Available'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (question)
                        ? isMyQuestions
                            ? controller.userQuestionsList.length
                            : isBookMarks
                                ? controller.bookmarkQuesList.length
                                : controller.allQuestionsList.length
                        : isMyPosts
                            ? controller.userPostsList.length
                            : isBookMarks
                                ? controller.bookmarkPostsList.length
                                : controller.allPostsList.length,
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
                                media: "",
                                type: "",
                                userCreated: null,
                                likesCount: '',
                                commentsCount: '',
                                isLikedByUser: false,
                                isCommentedByUser: false,
                                isSavedByUser: false,
                              )
                            : isMyPosts
                                ? controller.userPostsList[i]
                                : isBookMarks
                                    ? controller.bookmarkPostsList[i]
                                    : controller.allPostsList[i],
                        questionsData: question
                            ? isMyQuestions
                                ? controller.userQuestionsList[i]
                                : isBookMarks
                                    ? controller.bookmarkQuesList[i]
                                    : controller.allQuestionsList[i]
                            : Question(
                                id: '',
                                body: '',
                                tags: [],
                                likesCount: '',
                                commentsCount: '',
                                isLikedByUser: false,
                                isCommentedByUser: false,
                                isSavedByUser: false,
                              ),
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
                      child: widget.postdata!.type == "text"
                          ? Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF1F1F1),
                                  border: Border.all(color: const Color(0xffE7E6E6)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: _PostDetails(
                                postData: widget.postdata!,
                                questionsData: widget.questionsData,
                                screenWidth: screenWidth,
                                onTap: () {
                                  setState(() {
                                    isPressed = !isPressed;
                                  });
                                },
                                onPressed: isPressed,
                                controller: controller,
                                index: widget.index,
                                question: widget.question,
                              ),
                            )
                          : widget.postdata!.type == "image"
                              ? CachedNetworkImage(
                                  placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                                  imageUrl: 'https://picsum.photos/250?image=9',
                                )
                              : ClipRRect(
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
                      postData: widget.postdata!,
                      questionsData: widget.questionsData,
                      screenWidth: screenWidth,
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      },
                      onPressed: isPressed,
                      controller: controller,
                      index: widget.index,
                      question: widget.question,
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
                postData: widget.postdata!,
                questionsData: widget.questionsData,
                screenWidth: screenWidth,
                onTap: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                },
                onPressed: isPressed,
                controller: controller,
                index: widget.index,
                question: widget.question,
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
    this.mentionedUser = ' BishenPonnanna',
    required this.onPressed,
    required this.controller,
    required this.index,
    required this.postData,
    required this.questionsData,
    required this.question,
  }) : super(key: key);

  final double screenWidth;
  final void Function()? onTap;
  final bool onPressed;
  final String mentionedUser;
  final HomeController controller;
  final int index;
  final PostModel postData;
  final Question questionsData;
  final bool question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // post icons
        (question)
            ? PostCaption(
                tags: this.postData.tags,
                screenWidth: screenWidth,
                text: questionsData.body!,
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 3, left: 13, right: 16, top: 13),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        print(postData.isLikedByUser);
                        if (postData.isLikedByUser) {
                          List<Errors>? postUnlike = await controller.unlikeAPost(postData.id);
                          String? errorMessage = postUnlike!.first.message;
                        } else {
                          bool postLiked = await controller.likeAPost(postData.id);

                          if (postLiked) {
                            controller.allPostsList[index] = PostModel(
                                id: postData.id,
                                status: postData.status,
                                userCreated: postData.userCreated,
                                dateCreated: postData.dateCreated,
                                userUpdated: postData.userUpdated,
                                dateUpdated: postData.dateUpdated,
                                body: postData.body,
                                tags: postData.tags,
                                media: postData.media,
                                type: postData.type,
                                likesCount: (int.parse(postData.likesCount) + 1).toString(),
                                commentsCount: postData.commentsCount,
                                isLikedByUser: true,
                                isCommentedByUser: postData.isCommentedByUser,
                                isSavedByUser: postData.isSavedByUser);
                          }
                        }
                      },
                      child: _PostIcon(
                        image: postData.isLikedByUser ? "assets/images/post-liked.png" : "assets/images/post-unliked.png",
                        text: postData.likesCount,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.postId.value = postData.id;
                        Get.toNamed(AppRouter.commentScreen, arguments: postData.id);
                      },
                      child: _PostIcon(image: "assets/images/comment.png", text: postData.commentsCount),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    const _PostIcon(image: "assets/images/share.png", text: "Share"),
                    const Spacer(),
                    GestureDetector(
                      onTap: onTap,
                      child: _PostIcon(
                        image: (postData.isSavedByUser) ? "assets/images/saved.png" : "assets/images/save.png",
                        text: "",
                      ),
                    ),
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
                        if (questionsData.isLikedByUser!) {
                          List<Errors>? postUnlike = await controller.unlikeAQuestion(questionsData.id!);
                          String? errorMessage = postUnlike!.first.message;
                        } else {
                          bool quesLiked = await controller.likeAQuestion(questionsData.id!, index);

                          if (quesLiked) {
                            controller.allQuestionsList[index] = Question(
                              id: questionsData.id,
                              dateCreated: questionsData.dateCreated,
                              userCreated: questionsData.userCreated,
                              media: questionsData.media,
                              body: questionsData.body,
                              tags: questionsData.tags,
                              likesCount: (int.parse(questionsData.likesCount!) + 1).toString(),
                              commentsCount: questionsData.commentsCount,
                              isLikedByUser: true,
                              isCommentedByUser: questionsData.isCommentedByUser,
                              isSavedByUser: questionsData.isSavedByUser,
                            );
                          }

                          // controller.getLikeCountByQuestionId(questionsData.id!);
                        }
                      },
                      child: _PostIcon(
                        image: questionsData.isLikedByUser! ? "assets/images/post-liked.png" : "assets/images/post-unliked.png",
                        text: questionsData.likesCount!,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    _PostIcon(image: "assets/images/comment.png", text: questionsData.commentsCount!),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    const _PostIcon(image: "assets/images/share.png", text: "Share"),
                    const Spacer(),
                    GestureDetector(
                      onTap: onTap,
                      child: _PostIcon(
                        image: (questionsData.isSavedByUser!) ? "assets/images/saved.png" : "assets/images/save.png",
                        text: "",
                      ),
                    ),
                  ],
                ),
              )
            : PostCaption(
                tags: this.postData.tags,
                user: this.mentionedUser,
                screenWidth: screenWidth,
                text: this.postData.body!,
              ),

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
