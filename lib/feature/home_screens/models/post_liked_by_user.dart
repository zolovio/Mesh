class PostLikedByUser {
  List<Data>? data;

  PostLikedByUser({this.data});

  PostLikedByUser.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? id;
  String? userCreated;
  String? dateCreated;
  String? post;

  Data({this.id, this.userCreated, this.dateCreated, this.post});

  Data.fromJson(Map<String, dynamic> json) {
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
