import 'dart:convert';

class AuthTokenModel {
  String? accessToken;
  int? expires;
  String? refreshToken;

  AuthTokenModel({
    required this.accessToken,
    required this.expires,
    required this.refreshToken,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> jsonData) =>
      AuthTokenModel(
        accessToken: jsonData['access_token'],
        expires: jsonData['expires'],
        refreshToken: jsonData['refresh_token'],
      );

  static Map<String, dynamic> toMap(AuthTokenModel model) => <String, dynamic>{
        'access_token': model.accessToken,
        'expires': model.expires,
        'refresh_token': model.refreshToken,
      };

  static String serialize(AuthTokenModel model) =>
      json.encode(AuthTokenModel.toMap(model));

  static AuthTokenModel deserialize(String json) =>
      AuthTokenModel.fromJson(jsonDecode(json));
}
