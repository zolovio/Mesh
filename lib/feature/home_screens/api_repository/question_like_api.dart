import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';

class QuestionLikeApis {
  static var client = http.Client();
  static final controller = HomeController();

  static Future getLikesCount(String questionId) async {
    var authData = await controller.storage.read(key: 'authTokenData');

    var response = await client.post(
      Uri.parse("https://mesh.kodagu.today/items/question_likes"),
      body: jsonEncode({"question": questionId}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData!).refreshToken}',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      // LikeCount likeCount =
      //     LikeCount.fromJson(jsonDecode(response.body)["data"][0]);
      // return likeCount;
      // return jsonDecode(response.body)["data"];
    } else {
      //show error message
      // return LikeCount();
      print("Error");
    }
  }
}
