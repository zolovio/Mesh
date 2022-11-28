import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/like_post_model.dart';
import 'package:mesh/feature/home_screens/models/post_like_model.dart';
import 'package:mesh/feature/home_screens/models/post_liked_by_user.dart';

class PostApi {
  static var client = http.Client();
  static final controller = HomeController();

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
      // return jsonDecode(response.body)["data"];
    } else {
      //show error message
      return LikeCount();
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
      return errorMessage;
    }
  }

  static Future<PostLikedByUser> postLikedByUser(String postId) async {
    var authData = await controller.storage.read(key: 'authTokenData');
    var userData = await controller.storage.read(key: 'userData');

    var response = await client.get(
      Uri.parse(
          "https://mesh.kodagu.today/items/post_likes?filter[post][_eq]=$postId&filter[user_created][_eq]=${json.decode(userData!)["data"][0]["id"]}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      PostLikedByUser likedPost =
          PostLikedByUser.fromJson(jsonDecode(response.body));
      return likedPost;
    } else {
      //show error message
      return PostLikedByUser();
    }
  }

  static Future<LikePost> commentOnAPost(String comment, String postId) async {
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

      LikePost likePost = LikePost.fromJson(jsonDecode(response.body));
      return likePost;
      // return jsonDecode(response.body)["data"];
    } else {
      //show error message
      return LikePost();
    }
  }
}
