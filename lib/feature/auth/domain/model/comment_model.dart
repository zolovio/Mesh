class CommentModel {
  Comment? data;

  CommentModel({this.data});

  CommentModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Comment.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
