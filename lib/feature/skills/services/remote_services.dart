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
