import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/auth/domain/model/comment_model.dart';
import 'package:mesh/feature/home_screens/home_tab/notification_tab.dart';
import 'package:mesh/feature/home_screens/models/comment_by_user_model.dart';
import 'package:mesh/feature/home_screens/models/create_question_model.dart';
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/file_model.dart';
import 'package:mesh/feature/home_screens/models/like_post_model.dart';
import 'package:mesh/feature/home_screens/models/post_like_model.dart';
import 'package:mesh/feature/home_screens/models/post_liked_by_user.dart';
import 'package:mesh/feature/home_screens/models/post_model.dart';
import 'package:mesh/feature/home_screens/models/questions_model.dart';
import 'package:mesh/feature/home_screens/services/remote_home_services.dart';
import 'package:mesh/screens/user_info_screen.dart';

import '../../../dependency/flutter_toast_dep.dart';
import '../home_tab/home_tab.dart';

class HomeController extends GetxController {
  List<Widget> pages = <Widget>[
    const HomeTab(),
    Container(),
    NotificationTab(),
    const UserInfoScreen(myprofile: true)
  ].obs;

  var selectedPage = 0.obs;
  var tags = false.obs;
  var business = false.obs;

  var isLoading = true.obs;
  var isUploading = false.obs;
  var postsList = <PostModel>[].obs;
  var filesList = <FileModel>[].obs;

  var postIdsList = <String>[].obs;
  var postLCList = <String>[].obs;
  var like_count = "0".obs;
  var like_post = false.obs;
  var postId = "".obs;
  var postLike = false.obs;
  var userLikedPostsList = [].obs;

  var questionsList = <Question>[].obs;

  RxString textFieldValue = "".obs;

  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
  }

  void fetchAllPosts() async {
    try {
      isLoading(true);
      var posts = await RemoteHomeServices.fetchposts();
      print('all posts: ${posts['data']}');

      if (posts != null) {
        for (var post in posts['data']) {
          String postId = PostModel.fromJson(post).id;

          String? count = await getLikesCount(postId);

          postLCList.add(count!);

          Count? userLike = await postLikedByUser(postId);

          if (userLike!.id != "0") {
            userLikedPostsList.add(true);
          } else {
            userLikedPostsList.add(false);
          }

          postsList.add(PostModel.fromJson(post));
        }

        if (kDebugMode) {
          print(postsList);
        }

        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  Future UploadPostMedia({
    required String filepath,
    required String postbody,
    required List<String> posttags,
    // required List<Map<String, String>> filesids,
    required String posttype,
  }) async {
    try {
      isUploading(true);
      var data = await RemoteHomeServices.UploadFile(filepath);
      print('all posts: ${data['data']}');
      if (data != null) {
        filesList.add(FileModel.fromJson(data));
        UploadPost(
            fileid: filesList[0].id.toString(),
            postbody: postbody,
            posttags: posttags,
            posttype: posttype);
        return filesList[0].id;
      }
      if (kDebugMode) {
        print(filesList);
        update();
      }
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.');
      isUploading(false);
      return null;
    }
  }

  void UploadPost({
    required fileid,
    required String postbody,
    required posttags,
    // required List<Map<String, String>> filesids,
    required String posttype,
  }) async {
    try {
      var data = await RemoteHomeServices.createpost(
          postbody: postbody,
          posttags: posttags,
          filesids: fileid == null
              ? null
              : [
                  {"directus_files_id": fileid.toString()}
                ],
          posttype: posttype);
      if (data != null) {
        try {
          // filesList.add(FileModel.fromJson(data));
          isUploading(false);
          FlutterToast.show(message: 'Post Uploaded');
        } catch (e) {
          isUploading(false);
          FlutterToast.show(message: 'Error while uploading post.1');
        }
      }
      if (kDebugMode) {
        print(filesList);
        update();
      }
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.$e');

      isUploading(false);
    }
  }

  Future<String?> getLikesCount(String postId) async {
    try {
      LikeCount likeCount = await RemoteHomeServices.getLikesCount(postId);

      return likeCount.count;
    } finally {
      update();
    }
  }

  Future<Count?> postLikedByUser(String postId) async {
    try {
      Count userLike = await RemoteHomeServices.postLikedByUser(postId);

      return userLike;
    } finally {
      update();
    }
  }

  Future<bool> likeAPost(String postId, int index) async {
    try {
      LikePost likePost = await RemoteHomeServices.likeAPost(postId);

      if (likePost.like!.id != null) {
        userLikedPostsList[index] = true;

        String? count = await getLikesCount(postId);

        postLCList[index] = count!;

        Count? userLike = await postLikedByUser(postId);

        if (userLike!.id != "0") {
          userLikedPostsList[index] = true;
        } else {
          userLikedPostsList[index] = false;
        }

        update();

        return true;
      } else {
        return false;
      }
    } finally {
      update();
    }
  }

  Future<List<Errors>?> unlikeAPost(String postId) async {
    try {
      ErrorMessage unlikePost = await RemoteHomeServices.unlikeAPost(postId);

      return unlikePost.errors;
    } finally {}
  }

  Future<Comment?> commentOnAPost(String comment, String postId) async {
    try {
      isLoading(true);

      Comment commented =
          await RemoteHomeServices.commentOnAPost(comment, postId);
      print(commented);

      return commented;
    } finally {
      isLoading(false);
    }
  }

  Future<CommentByUserModel> postCommentedByUser(String postId) async {
    try {
      isLoading(true);

      CommentByUserModel commentByUserModel =
          await RemoteHomeServices.postCommentedByUser(postId);

      return commentByUserModel;
    } finally {
      isLoading(false);
    }
  }

  Future<CreateQuestionModel?> createQuestion({
    required String quesBody,
    required quesTags,
  }) async {
    try {
      CreateQuestionModel data = await RemoteHomeServices.createQuestion(
        quesBody: quesBody,
        quesTags: quesTags,
      );

      if (data != null) {
        try {
          isUploading(false);
          FlutterToast.show(message: 'Post Uploaded');
        } catch (e) {
          isUploading(false);
          FlutterToast.show(message: 'Error while uploading post.1');
        }
      }
      if (kDebugMode) {
        print(filesList);
        update();
      }
      return data;
    } catch (e) {
      FlutterToast.show(message: 'Error while uploading post.$e');

      isUploading(false);
    }
  }

  void fetchAllQuestions() async {
    try {
      isLoading(true);

      if (questionsList.isNotEmpty) questionsList.clear();

      var questions = await RemoteHomeServices.fetchQuestions();

      print('all questions: ${questions['data']}');

      if (questions != null) {
        for (var question in questions['data']) {
          questionsList.add(Question.fromJson(question));
        }

        if (kDebugMode) {
          print(questionsList.length);
        }
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }
}
