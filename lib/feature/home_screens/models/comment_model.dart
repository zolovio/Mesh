class CommentModel {
  Comment? comment;

  CommentModel({this.comment});

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['data'] != null ? Comment.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.comment != null) {
      data['data'] = this.comment!.toJson();
    }
    return data;
  }
}

class Comment {
  String? id;
  String? userCreated;
  String? dateCreated;
  String? post;

  Comment({this.id, this.userCreated, this.dateCreated, this.post});

  Comment.fromJson(Map<String, dynamic> json) {
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
