// To parse this JSON data, do
//
//     final PostModel = PostModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> PostModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String PostModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    required this.id,
    required this.status,
    required this.dateCreated,
    required this.userUpdated,
    required this.dateUpdated,
    required this.body,
    required this.tags,
    required this.file,
    required this.type,
    required this.userCreated,
  });

  String id;
  String status;
  DateTime dateCreated;
  String userUpdated;
  DateTime? dateUpdated;
  String? body;
  List<String> tags;
  dynamic file;
  String type;
  UserCreated? userCreated;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        status: json["status"],
        dateCreated: DateTime.parse(json["date_created"]),
        userUpdated:
            json["user_updated"] == null ? 'null' : json["user_updated"],
        dateUpdated: json["date_updated"] == null
            ? null
            : DateTime.parse(json["date_updated"]),
        body: json["body"] == null ? null : json["body"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"].map((x) => x)),
        file: json["file"],
        type: json["type"],
        userCreated: json["user_created"] == null
            ? null
            : UserCreated.fromJson(json["user_created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "date_created": dateCreated.toIso8601String(),
        "user_updated": userUpdated == null ? null : userUpdated,
        "date_updated":
            dateUpdated == null ? null : dateUpdated!.toIso8601String(),
        "body": body,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "file": file,
        "type": type,
        "user_created": userCreated == null ? null : userCreated!.toJson(),
      };
}

class UserCreated {
  UserCreated({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.location,
    required this.title,
    required this.description,
    required this.tags,
    required this.avatar,
    required this.language,
    required this.theme,
    required this.tfaSecret,
    required this.status,
    required this.role,
    required this.token,
    required this.lastAccess,
    required this.lastPage,
    required this.provider,
    required this.externalIdentifier,
    required this.authData,
    required this.emailNotifications,
    required this.authType,
    required this.skills,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  dynamic location;
  dynamic title;
  dynamic description;
  dynamic tags;
  dynamic avatar;
  dynamic language;
  String theme;
  dynamic tfaSecret;
  String status;
  String role;
  dynamic token;
  DateTime lastAccess;
  String lastPage;
  String provider;
  dynamic externalIdentifier;
  dynamic authData;
  bool emailNotifications;
  String authType;
  List<dynamic> skills;

  factory UserCreated.fromJson(Map<String, dynamic> json) => UserCreated(
        id: json["id"],
        firstName: json["first_name"] == null ? "" : json["first_name"],
        lastName: json["last_name"] ?? "",
        email: json["email"],
        password: json["password"],
        location: json["location"],
        title: json["title"],
        description: json["description"],
        tags: json["tags"],
        avatar: json["avatar"],
        language: json["language"],
        theme: json["theme"],
        tfaSecret: json["tfa_secret"],
        status: json["status"],
        role: json["role"],
        token: json["token"],
        lastAccess: DateTime.parse(json["last_access"]),
        lastPage: json["last_page"] ?? "",
        provider: json["provider"],
        externalIdentifier: json["external_identifier"],
        authData: json["auth_data"],
        emailNotifications: json["email_notifications"],
        authType: json["auth_type"],
        skills: List<dynamic>.from(json["skills"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "location": location,
        "title": title,
        "description": description,
        "tags": tags,
        "avatar": avatar,
        "language": language,
        "theme": theme,
        "tfa_secret": tfaSecret,
        "status": status,
        "role": role,
        "token": token,
        "last_access": lastAccess.toIso8601String(),
        "last_page": lastPage,
        "provider": provider,
        "external_identifier": externalIdentifier,
        "auth_data": authData,
        "email_notifications": emailNotifications,
        "auth_type": authType,
        "skills": List<dynamic>.from(skills.map((x) => x)),
      };
}
