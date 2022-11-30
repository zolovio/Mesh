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
  String? userCreated;

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
    userCreated = json['user_created'];
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
    data['user_created'] = this.userCreated;
    return data;
  }
}
