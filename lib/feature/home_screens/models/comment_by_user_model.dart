class CommentByUserModel {
  List<String>? data;

  CommentByUserModel({this.data});

  CommentByUserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}
