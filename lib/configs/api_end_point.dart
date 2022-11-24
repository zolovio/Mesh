import 'package:mesh/feature/auth/domain/model/auth_token_model.dart';

abstract class APIEndpoints {
  static const String baseUrl = "https://mesh.kodagu.today/";
  static String users = baseUrl + 'users';
  static String getUser = baseUrl + 'users?filter[email][_eq]=';
  static String login = baseUrl + 'auth/login';
  static String skills = baseUrl + 'items/skill?filter[status][_eq]=published';

  /// For App Usage
  static AuthTokenModel? authTokenData;
}
