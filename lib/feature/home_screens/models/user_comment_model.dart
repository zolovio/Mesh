class UserCommentModel {
  UserComment? comment;

  UserCommentModel({this.comment});

  UserCommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['data'] != null ? UserComment.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.comment != null) {
      data['data'] = this.comment!.toJson();
    }
    return data;
  }
}

class UserComment {
  String? id;
  String? userCreated;
  String? dateCreated;
  String? post;

  UserComment({this.id, this.userCreated, this.dateCreated, this.post});

  UserComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCreated = json['user_created'];
    dateCreated = json['date_created'];
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_created'] = this.userCreated;
    data['date_created'] = this.dateCreated;
    data['post'] = this.post;
    return data;
  }
}
