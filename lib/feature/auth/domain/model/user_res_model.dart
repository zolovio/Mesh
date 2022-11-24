class UserResModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? location;
  String? title;
  String? description;
  String? tags;
  String? avatar;
  String? language;
  String? theme;
  String? tfaSecret;
  String? status;
  String? role;
  String? token;
  String? lastAccess;
  String? lastPage;
  String? provider;
  String? externalIdentifier;
  String? authData;
  bool? emailNotifications;

  UserResModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.location,
      this.title,
      this.description,
      this.tags,
      this.avatar,
      this.language,
      this.theme,
      this.tfaSecret,
      this.status,
      this.role,
      this.token,
      this.lastAccess,
      this.lastPage,
      this.provider,
      this.externalIdentifier,
      this.authData,
      this.emailNotifications});

  UserResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    location = json['location'];
    title = json['title'];
    description = json['description'];
    tags = json['tags'];
    avatar = json['avatar'];
    language = json['language'];
    theme = json['theme'];
    tfaSecret = json['tfa_secret'];
    status = json['status'];
    role = json['role'];
    token = json['token'];
    lastAccess = json['last_access'];
    lastPage = json['last_page'];
    provider = json['provider'];
    externalIdentifier = json['external_identifier'];
    authData = json['auth_data'];
    emailNotifications = json['email_notifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['location'] = location;
    data['title'] = title;
    data['description'] = description;
    data['tags'] = tags;
    data['avatar'] = avatar;
    data['language'] = language;
    data['theme'] = theme;
    data['tfa_secret'] = tfaSecret;
    data['status'] = status;
    data['role'] = role;
    data['token'] = token;
    data['last_access'] = lastAccess;
    data['last_page'] = lastPage;
    data['provider'] = provider;
    data['external_identifier'] = externalIdentifier;
    data['auth_data'] = authData;
    data['email_notifications'] = emailNotifications;
    return data;
  }
}

class GetUsersRes {
  List<UserResModel>? data;

  GetUsersRes({this.data});

  GetUsersRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserResModel>[];
      json['data'].forEach((v) {
        data!.add(UserResModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
