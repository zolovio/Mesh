import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesh/feature/skills/controllers/skill_controller.dart';

import '../../auth/domain/model/auth_token_model.dart';

class RemoteServices {
  static var client = http.Client();
  static final controller = SkillsController();
  static Future fetchactiveskills() async {
    var authData = await controller.storage.read(key: 'authTokenData');
    print(AuthTokenModel.deserialize(authData!).accessToken);
    var response = await client.get(
      Uri.parse(
          'https://mesh.kodagu.today/items/skill?filter[status][_eq]=published'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${AuthTokenModel.deserialize(authData).accessToken}',
      },
    );
    if (response.statusCode == 200) {
      // var jsonString = response.body.toString();

      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }

  static Future updateactiveskills(
      {required List skillids, required String uid}) async {
    var body = jsonEncode({"skills": skillids});
    var response = await client
        .patch(Uri.parse('https://mesh.kodagu.today/users/$uid'), body: body);
    if (response.statusCode == 200) {
      print(response.body);

      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }
}
