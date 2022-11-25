import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteHomeServices {
  static var client = http.Client();
  static Future fetchposts() async {
    var response = await client.get(Uri.parse(
        'https://mesh.kodagu.today/items/post?fiter[status][_eq]=published&fields=*,files.directus_files_id,user_created.*'));
    if (response.statusCode == 200) {
      // var jsonString = response.body.toString();

      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }
}
