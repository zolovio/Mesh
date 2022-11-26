import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesh/feature/home_screens/models/error_message.dart';
import 'package:mesh/feature/home_screens/models/like_post_model.dart';
import 'package:mesh/feature/home_screens/models/post_like_model.dart';

class PostLikesApi {
  static var client = http.Client();

  static Future<LikeCount> getLikesCount(String postId) async {
    var response = await client.get(Uri.parse(
        "https://mesh.kodagu.today/items/post_likes?filter[post][_eq]=$postId&aggregate[count]=*"));

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
    var response = await client.post(
        Uri.parse("https://mesh.kodagu.today/items/post_likes"),
        body: {"post": "424dd25f-3c3f-44e8-b43f-0febfe72deea"});

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
    var response = await client.delete(
        Uri.parse("https://mesh.kodagu.today/items/post_likes/$postId"));

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
}
