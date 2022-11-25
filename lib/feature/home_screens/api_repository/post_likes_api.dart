import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesh/feature/auth/domain/model/post_like_model.dart';

class PostLikesApi {
  static var client = http.Client();

  static Future<LikeCount> getLikesCount(String postId) async {
    var response = await client.get(Uri.parse(
        "https://mesh.kodagu.today/items/post_likes?filter[post][_eq]=aafaea28-0885-4a14-b797-a3a455aaa950&aggregate[count]=*"));

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
}
