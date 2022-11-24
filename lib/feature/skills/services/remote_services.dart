import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future fetchactiveskills() async {
    var response = await client.get(Uri.parse(
        'https://mesh.kodagu.today/items/skill?filter[status][_eq]=published'));
    if (response.statusCode == 200) {
      var jsonString = response.body.toString();

      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }

  static Future updateactiveskills() async {
    var response = await client.get(Uri.parse(
        'https://mesh.kodagu.today/users/634a4d8b-e71a-493d-bbed-eadb98da3f54'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }
}
