import 'dart:convert';
import 'dart:io';

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

  static Future UploadFile(String filepath) async {
    var postUri = Uri.parse("https://mesh.kodagu.today/files");
    var request = http.MultipartRequest('POST', postUri);
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
      //show error message
      return null;
    }
  }

  static Future createpost({
    required String postbody,
    required List<String> posttags,
    required List<Map<String, String>> filesids,
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
    var response = await client
        .post(Uri.parse('https://mesh.kodagu.today/items/post'), body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return jsonDecode(response.body.toString());
    } else {
      //show error message
      return null;
    }
  }
}
