class QuesLikesByIdModel {
  List<String>? data;

  QuesLikesByIdModel({this.data});

  QuesLikesByIdModel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    return data;
  }
}
