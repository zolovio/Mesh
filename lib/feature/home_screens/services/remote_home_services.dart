import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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
      print(response.body.toString());

      AuthTokenModel authTokenModel =
          AuthTokenModel.fromJson(json.decode(response.body)["data"]);

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
      print(response.statusCode);
      print(response.body);
      //show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      //show error message
      return null;
    }
  }

  static Future fetchposts() async {
    print('fetching posts');
    var authData = await controller.storage.read(key: 'authTokenData');
    print(AuthTokenModel.deserialize(authData!).accessToken);
    var response = await client.get(
      Uri.parse(
          'https://mesh.kodagu.today/items/post?fiter[status][_eq]=published&fields=*,files.directus_files_id,user_created.*'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      // var jsonString = response.body.toString();
      print(response.body);
      refreshToken();

      return jsonDecode(response.body.toString());
    } else {
      print(response.statusCode);
      //show error message
      // FlutterToast.show(
      //     message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
      return null;
    }
  }

  static Future UploadFile(String filepath) async {
    var authData = await controller.storage.read(key: 'authTokenData');
    print(AuthTokenModel.deserialize(authData!).accessToken);
    var postUri = Uri.parse("https://mesh.kodagu.today/files");
    var request = http.MultipartRequest(
      'POST',
      postUri,
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${AuthTokenModel.deserialize(authData).accessToken}',
    });
    request.files.add(http.MultipartFile('file',
        File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
        filename: filepath.split("/").last));
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    if (response.statusCode == 200) {
      // var jsonString = response.body.toString();

      return jsonDecode(responseString);
    } else {
      print(response.statusCode);
      // print(response.body);
      //  print(response.statusCode);
      //show error message
      // FlutterToast.show(
      //     message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
      //show error message
      return null;
    }
  }

  static Future<Publish> createpost({
    required postbody,
    required List<String> posttags,
    required filesids,
    required String posttype,
  }) async {
    var body = jsonEncode({
      "status": "published",
      "body": postbody,
      "tags": posttags,
      "type": posttype,
      "files": filesids
      // [
      // {"directus_files_id": "00a7f281-69ee-4bb1-93e8-f833721c13cc"},
      //   {"directus_files_id": "00a7f281-69ee-4bb1-93e8-f833721c13cc"},
      //   {"directus_files_id": "00a7f281-69ee-4bb1-93e8-f833721c13cc"}
      // ]
    });
    var authData = await controller.storage.read(key: 'authTokenData');
    print(AuthTokenModel.deserialize(authData!).accessToken);
    var response = await client.post(
      Uri.parse('https://mesh.kodagu.today/items/post'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body.toString());

      Publish publish = Publish.fromJson(jsonDecode(response.body)["data"]);
      return publish;
    } else {
      // print(response.statusCode);
      if (kDebugMode) {
        print(response.body);
      }
      controller.isUploading(false);
      controller.update();
      print(response.statusCode);
      print(response.body);
      //show error message
      // FlutterToast.show(
      //     message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
      //show error message
      return Publish();
    }
  }

  static Future<LikeCount> getLikesCount(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/post_likes?filter[post][_eq]=$postId&aggregate[count]=*"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      LikeCount likeCount =
          LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
    } else {
      print(response.statusCode);
      // show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      Count likedPost =
          Count.fromJson(jsonDecode(response.body)["data"][0]["count"]);
      return likedPost;
    } else {
      //show error message
      ErrorMessage.fromJson(jsonDecode(response.body));

      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();

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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      LikePost likePost = LikePost.fromJson(jsonDecode(response.body));
      return likePost;
      // return jsonDecode(response.body)["data"];
    } else {
      //show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      LikeCount likeCount =
          LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
      // return jsonDecode(response.body)["data"];
    } else {
      //show error message

      ErrorMessage errorMessage =
          ErrorMessage.fromJson(jsonDecode(response.body));
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      UserComment commentModel =
          UserComment.fromJson(jsonDecode(response.body)["data"]);
      return commentModel;
      // return jsonDecode(response.body)["data"];
    } else {
      //show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();

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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      CommentByUserModel writeCommentModel =
          CommentByUserModel.fromJson(jsonDecode(response.body));
      return writeCommentModel;
    } else {
      //show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
      print(response.body);

      return CommentByUserModel();
    }
  }

  static Future fetchAllQuestions() async {
    print('fetching questions');
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse(
          'https://mesh.kodagu.today/items/question?fiter[statu][_eq]=published&fields=*,user_created.*'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body.toString());
    } else {
      print(response.statusCode);
      // show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body.toString());
    } else {
      print(response.statusCode);
      // show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      print(response.body.toString());

      CreateQuestion createQuestion =
          CreateQuestion.fromJson(jsonDecode(response.body)["data"]);
      return createQuestion;
    } else {
      //show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();

      print(response.body);
      return CreateQuestion();
    }
  }

  static Future<QuesLikesByIdModel> getQuestionLikesById(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/question_likes?filter[question][_eq]=$quesId&fields=user_created.*"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(jsonDecode(response.body)["data"][0]);

      QuesLikesByIdModel model =
          QuesLikesByIdModel.fromJson(jsonDecode(response.body)["data"]);
      return model;
    } else {
      print(response.statusCode);
      // show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
      return QuesLikesByIdModel();
    }
  }

  static Future<LikeCount> getQuestionLikeCountById(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/question_likes?filter[question][_eq]=$quesId&aggregate[count]=*"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(jsonDecode(response.body)["data"][0]);

      LikeCount likeCount =
          LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
    } else {
      print(response.statusCode);
      // show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
      return LikeCount();
    }
  }

  // static Future<Count>
  static Future quesLikedByUser(String quesId) async {
    var authData = await controller.storage.read(key: 'authTokenData');
    var userData = await controller.storage.read(key: 'userData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/question_likes?filter[question][_eq]=$quesId&filter[user_created][_eq]=${json.decode(userData!)["data"][0]["id"]}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      // Count likedPost =
      //     Count.fromJson(jsonDecode(response.body)["data"][0]["count"]);
      return jsonDecode(response.body)["data"];
    } else {
      //show error message
      ErrorMessage.fromJson(jsonDecode(response.body));

      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();

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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      LikeQuestion likeQuestion =
          LikeQuestion.fromJson(jsonDecode(response.body));
      return likeQuestion;
    } else {
      //show error message
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
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
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      LikeCount likeCount =
          LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      return likeCount;
      // return jsonDecode(response.body)["data"];
    } else {
      //show error message

      ErrorMessage errorMessage =
          ErrorMessage.fromJson(jsonDecode(response.body));
      FlutterToast.show(
          message: jsonDecode(response.body)['errors'][0]['message']);
      refreshToken();
      return errorMessage;
    }
  }
}
