import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/dependency/flutter_toast_dep.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/models/comment_by_user_model.dart';
import 'package:mesh/feature/home_screens/models/create_question_model.dart';
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/like_post_model.dart';
import 'package:mesh/feature/home_screens/models/like_question_model.dart';
import 'package:mesh/feature/home_screens/models/post_like_model.dart';
import 'package:mesh/feature/home_screens/models/post_liked_by_user.dart';
import 'package:mesh/feature/home_screens/models/post_publish_model.dart';
import 'package:mesh/feature/home_screens/models/ques_likes_by_id_model.dart';
import 'package:mesh/feature/home_screens/models/user_comment_model.dart';

import '../../auth/domain/model/auth_token_model.dart';

class RemoteHomeServices {
  static var client = http.Client();
  static final controller = HomeController();

  static Future refreshToken() async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var body = json.encode({
      "refresh_token": '${AuthTokenModel.deserialize(authData!).refreshToken}',
    });

    print('body: $body');

    var response = await client.post(
      Uri.parse('https://mesh.kodagu.today/auth/refresh'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      AuthTokenModel authTokenModel = AuthTokenModel.fromJson(json.decode(response.body)["data"]);

      // await controller.storage.delete(key: "authTokenData");

      await controller.storage.write(
        key: 'authTokenData',
        value: AuthTokenModel.serialize(
          AuthTokenModel(
            accessToken: authTokenModel.accessToken,
            expires: authTokenModel.expires,
            refreshToken: authTokenModel.refreshToken,
          ),
        ),
      );
      return jsonDecode(response.body.toString());
    } else {
      //show error message
      FlutterToast.show(message: jsonDecode(response.body)['errors'][0]['message']);

      Get.offAndToNamed(AppRouter.loginScreen);

      return jsonDecode(response.body);
    }
  }

  static Future<http.Response> getNotifications() async {
    var authData = await controller.storage.read(key: 'authTokenData');

    String url = "https://d4d.agpro.co.in/items/notifications";

    var data = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    return data;
  }

  static Future fetchAllPosts() async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse('https://mesh.kodagu.today/custom/allpost/-1/1'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body.toString());
    } else {
      refreshToken();
      return null;
    }
  }

  static Future fetchUserPosts() async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse('https://mesh.kodagu.today/custom/userpost/-1/1'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body.toString());
    } else {
      refreshToken();
      return null;
    }
  }

  static Future fetchMediaFile(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse("https://mesh.kodagu.today/assets/$postId"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body);
    } else {
      // await refreshToken();

      return null;
    }
  }

  static Future UploadFile(String filepath) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var postUri = Uri.parse("https://mesh.kodagu.today/files");
    var request = http.MultipartRequest(
      'POST',
      postUri,
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
    });
    request.files
        .add(http.MultipartFile('file', File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(), filename: filepath.split("/").last));
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 200) {
      return jsonDecode(responseString);
    } else {
      await refreshToken();
      return null;
    }
  }

  static Future<Publish> createpost({
    required postbody,
    required List<String> posttags,
    required filesids,
    required String posttype,
  }) async {
    var body = jsonEncode({"status": "published", "body": postbody, "tags": posttags, "type": posttype, "files": filesids});

    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.post(
      Uri.parse('https://mesh.kodagu.today/items/post'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      Publish publish = Publish.fromJson(jsonDecode(response.body)["data"]);
      return publish;
    } else {
      if (kDebugMode) {
        print(response.body);
      }

      controller.isUploading(false);
      controller.update();

      await refreshToken();

      return Publish();
    }
  }

  static Future<LikeCount> getLikesCount(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse("https://mesh.kodagu.today/items/post_likes?filter[post][_eq]=$postId&aggregate[count]=*"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      LikeCount likeCount = LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
    } else {
      await refreshToken();

      return LikeCount();
    }
  }

  static Future<Count> postLikedByUser(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');
    var userData = await controller.storage.read(key: 'userData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/post_likes?filter[post][_eq]=$postId&filter[user_created][_eq]=${json.decode(userData!)["data"][0]["id"]}&aggregate[count]=id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      Count likedPost = Count.fromJson(jsonDecode(response.body)["data"][0]["count"]);
      return likedPost;
    } else {
      await refreshToken();

      return Count();
    }
  }

  static Future<LikePost> likeAPost(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.post(
      Uri.parse("https://mesh.kodagu.today/items/post_likes"),
      body: jsonEncode({"post": postId}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      LikePost likePost = LikePost.fromJson(jsonDecode(response.body));
      return likePost;
    } else {
      await refreshToken();

      return LikePost();
    }
  }

  static Future unlikeAPost(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.delete(
      Uri.parse("https://mesh.kodagu.today/items/post_likes/$postId"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      LikeCount likeCount = LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
    } else {
      ErrorMessage errorMessage = ErrorMessage.fromJson(jsonDecode(response.body));

      FlutterToast.show(message: jsonDecode(response.body)['errors'][0]['message']);

      // await refreshToken();

      return errorMessage;
    }
  }

  static Future commentOnAPost(String comment, String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.post(
      Uri.parse("https://mesh.kodagu.today/items/post_likes"),
      body: jsonEncode({"body": comment, "post": postId}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      UserComment commentModel = UserComment.fromJson(jsonDecode(response.body)["data"]);
      return commentModel;
    } else {
      await refreshToken();

      return LikePost();
    }
  }

  static Future<CommentByUserModel> postCommentedByUser(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');
    var userData = await controller.storage.read(key: 'userData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/post_comments?filter[post][_eq]=$postId&filter[user_created][_eq]=${json.decode(userData!)["data"][0]["id"]}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      CommentByUserModel writeCommentModel = CommentByUserModel.fromJson(jsonDecode(response.body));
      return writeCommentModel;
    } else {
      await refreshToken();

      return CommentByUserModel();
    }
  }

  static Future fetchAllQuestions() async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse('https://mesh.kodagu.today/custom/allquestion/-1/1'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body.toString());
    } else {
      // show error message
      FlutterToast.show(message: jsonDecode(response.body)['errors'][0]['message']);

      await refreshToken();

      return null;
    }
  }

  static Future fetchUserQuestions() async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse('https://mesh.kodagu.today/custom/userquestion/-1/1'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body.toString());
    } else {
      // show error message
      FlutterToast.show(message: jsonDecode(response.body)['errors'][0]['message']);

      await refreshToken();

      return null;
    }
  }

  static Future fetchAllQuestionByUserId() async {
    var authData = await controller.storage.read(key: 'authTokenData');
    var userData = await controller.storage.read(key: 'userData');

    var response = await client.get(
      Uri.parse(
          'https://mesh.kodagu.today/items/question?fiter[status][_eq]=published&fields=*,user_created.*&filter[user_created][_eq]=${json.decode(userData!)["data"][0]["id"]}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      await refreshToken();

      return null;
    }
  }

  static Future<CreateQuestion> createQuestion({
    required quesBody,
    required List<String> quesTags,
  }) async {
    var body = jsonEncode({
      "status": "published",
      "body": quesBody,
      "tags": quesTags,
    });

    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.post(
      Uri.parse('https://mesh.kodagu.today/items/question'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      CreateQuestion createQuestion = CreateQuestion.fromJson(jsonDecode(response.body)["data"]);

      return createQuestion;
    } else {
      await refreshToken();

      return CreateQuestion();
    }
  }

  static Future<QuesLikesByIdModel> getQuestionLikesById(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse("https://mesh.kodagu.today/items/question_likes?filter[question][_eq]=$quesId&fields=user_created.*"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      QuesLikesByIdModel model = QuesLikesByIdModel.fromJson(jsonDecode(response.body)["data"]);
      return model;
    } else {
      await refreshToken();

      return QuesLikesByIdModel();
    }
  }

  static Future<LikeCount> getQuestionLikeCountById(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse("https://mesh.kodagu.today/items/question_likes?filter[question][_eq]=$quesId&aggregate[count]=*"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      LikeCount likeCount = LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
    } else {
      await refreshToken();

      return LikeCount();
    }
  }

  static Future quesLikedByUser(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');
    var userData = await controller.storage.read(key: 'userData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/question_likes?filter[question][_eq]=$quesId&filter[user_created][_eq]=${json.decode(userData!)["data"][0]["id"]}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      await refreshToken();

      return Count();
    }
  }

  static Future<LikeQuestion> likeAQuestion(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.post(
      Uri.parse("https://mesh.kodagu.today/items/question_likes"),
      body: jsonEncode({"question": quesId}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      LikeQuestion likeQuestion = LikeQuestion.fromJson(jsonDecode(response.body)["data"]);
      return likeQuestion;
    } else {
      //show error message
      FlutterToast.show(message: jsonDecode(response.body)['errors'][0]['message']);

      await refreshToken();

      return LikeQuestion();
    }
  }

  static Future unlikeAQuestion(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.delete(
      Uri.parse("https://mesh.kodagu.today/items/question_likes/$quesId"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      LikeCount likeCount = LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
    } else {
      //show error message

      ErrorMessage errorMessage = ErrorMessage.fromJson(jsonDecode(response.body));

      FlutterToast.show(message: jsonDecode(response.body)['errors'][0]['message']);

      await refreshToken();

      return errorMessage;
    }
  }
}
