class QuestionsModel {
  List<Question>? data;

  QuestionsModel({this.data});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Question>[];
      json['data'].forEach((v) {
        data!.add(Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String? id;
  String? status;
  String? dateCreated;
  String? userUpdated;
  String? dateUpdated;
  String? body;
  List<String>? tags;
  UserCreated? userCreated;

  Question(
      {this.id,
      this.status,
      this.dateCreated,
      this.userUpdated,
      this.dateUpdated,
      this.body,
      this.tags,
      this.userCreated});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    dateCreated = json['date_created'];
    userUpdated = json['user_updated'];
    dateUpdated = json['date_updated'];
    body = json['body'];
    tags = json['tags'].cast<String>();
    userCreated = json['user_created'] != null
        ? new UserCreated.fromJson(json['user_created'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    data['user_updated'] = this.userUpdated;
    data['date_updated'] = this.dateUpdated;
    data['body'] = this.body;
    data['tags'] = this.tags;
    if (this.userCreated != null) {
      data['user_created'] = this.userCreated!.toJson();
    }
    return data;
  }
}

class UserCreated {
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
  String? authType;
  String? deviceToken;
  List<Skills>? skills;

  UserCreated(
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
      this.emailNotifications,
      this.authType,
      this.deviceToken,
      this.skills});

  UserCreated.fromJson(Map<String, dynamic> json) {
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
    authType = json['auth_type'];
    deviceToken = json['device_token'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['location'] = this.location;
    data['title'] = this.title;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['avatar'] = this.avatar;
    data['language'] = this.language;
    data['theme'] = this.theme;
    data['tfa_secret'] = this.tfaSecret;
    data['status'] = this.status;
    data['role'] = this.role;
    data['token'] = this.token;
    data['last_access'] = this.lastAccess;
    data['last_page'] = this.lastPage;
    data['provider'] = this.provider;
    data['external_identifier'] = this.externalIdentifier;
    data['auth_data'] = this.authData;
    data['email_notifications'] = this.emailNotifications;
    data['auth_type'] = this.authType;
    data['device_token'] = this.deviceToken;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skills {
  int? id;
  String? status;
  String? title;
  String? icon;

  Skills({this.id, this.status, this.title, this.icon});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    title = json['title'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['icon'] = this.icon;
    return data;
  }
}
