import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future fetchactiveskills() async {
    var response = await client.get(Uri.parse(
        'https://mesh.kodagu.today/items/skill?filter[status][_eq]=published'));
    if (response.statusCode == 200) {
      // var jsonString = response.body.toString();

      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }

  static Future updateactiveskills({required List skillid}) async {
    var body = {
      "skills": [
        {"skill_id": "2"},
        {"skill_id": "1"}
      ]
    };
    var response = await client.patch(
        Uri.parse(
            'https://mesh.kodagu.today/users/634a4d8b-e71a-493d-bbed-eadb98da3f54'),
        body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }
}
