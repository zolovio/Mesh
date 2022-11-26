class PostLikeModel {
  List<LikeCount>? data;

  PostLikeModel({this.data});

  PostLikeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LikeCount>[];
      json['data'].forEach((v) {
        data!.add(LikeCount.fromJson(v));
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

class LikeCount {
  String? count;

  LikeCount({this.count});

  LikeCount.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = this.count;
    return data;
  }
}
