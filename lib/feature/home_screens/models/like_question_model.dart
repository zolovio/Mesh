class LikeQuestionModel {
  LikeQuestion? data;

  LikeQuestionModel({this.data});

  LikeQuestionModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? LikeQuestion.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LikeQuestion {
  String? id;
  String? userCreated;
  String? dateCreated;
  String? question;

  LikeQuestion({this.id, this.userCreated, this.dateCreated, this.question});

  LikeQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCreated = json['user_created'];
    dateCreated = json['date_created'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_created'] = this.userCreated;
    data['date_created'] = this.dateCreated;
    data['question'] = this.question;
    return data;
  }
}
