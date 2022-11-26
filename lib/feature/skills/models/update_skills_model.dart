class UpdateSkillsModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  Null? location;
  Null? title;
  Null? description;
  Null? tags;
  Null? avatar;
  Null? language;
  String? theme;
  Null? tfaSecret;
  String? status;
  String? role;
  Null? token;
  String? lastAccess;
  Null? lastPage;
  String? provider;
  Null? externalIdentifier;
  Null? authData;
  bool? emailNotifications;
  String? authType;
  List<int>? skills;

  UpdateSkillsModel(
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
      this.skills});

  UpdateSkillsModel.fromJson(Map<String, dynamic> json) {
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
    skills = json['skills'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['skills'] = this.skills;
    return data;
  }
}
