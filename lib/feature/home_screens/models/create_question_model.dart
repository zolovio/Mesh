class CreateQuestionModel {
  CreateQuestion? data;

  CreateQuestionModel({this.data});

  CreateQuestionModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new CreateQuestion.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CreateQuestion {
  String? id;
  String? status;
  String? userCreated;
  String? dateCreated;
  String? userUpdated;
  String? dateUpdated;
  String? body;
  List<String>? tags;

  CreateQuestion(
      {this.id,
      this.status,
      this.userCreated,
      this.dateCreated,
      this.userUpdated,
      this.dateUpdated,
      this.body,
      this.tags});

  CreateQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userCreated = json['user_created'];
    dateCreated = json['date_created'];
    userUpdated = json['user_updated'];
    dateUpdated = json['date_updated'];
    body = json['body'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['status'] = this.status;
    data['user_created'] = this.userCreated;
    data['date_created'] = this.dateCreated;
    data['user_updated'] = this.userUpdated;
    data['date_updated'] = this.dateUpdated;
    data['body'] = this.body;
    data['tags'] = this.tags;
    return data;
  }
}
