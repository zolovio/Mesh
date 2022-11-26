class LikePost {
  Like? like;

  LikePost({this.like});

  LikePost.fromJson(Map<String, dynamic> json) {
    like = json['data'] != null ? Like.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.like != null) {
      data['data'] = this.like!.toJson();
    }
    return data;
  }
}

class Like {
  String? id;
  String? userCreated;
  String? dateCreated;
  String? post;

  Like({this.id, this.userCreated, this.dateCreated, this.post});

  Like.fromJson(Map<String, dynamic> json) {
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
