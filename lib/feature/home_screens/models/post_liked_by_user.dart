class PostLikedByUser {
  List<Data>? data;

  PostLikedByUser({this.data});

  PostLikedByUser.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Count? count;

  Data({this.count});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    return data;
  }
}

class Count {
  String? id;

  Count({this.id});

  Count.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

// class PostLikedByUser {
//   List<UserLikePost>? data;
//
//   PostLikedByUser({this.data});
//
//   PostLikedByUser.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <UserLikePost>[];
//       json['data'].forEach((v) {
//         data!.add(UserLikePost.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class UserLikePost {
//   String? id;
//   String? userCreated;
//   String? dateCreated;
//   String? post;
//
//   UserLikePost({this.id, this.userCreated, this.dateCreated, this.post});
//
//   UserLikePost.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userCreated = json['user_created'];
//     dateCreated = json['date_created'];
//     post = json['post'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = this.id;
//     data['user_created'] = this.userCreated;
//     data['date_created'] = this.dateCreated;
//     data['post'] = this.post;
//     return data;
//   }
// }
