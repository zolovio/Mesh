class ActiveSkillsModel {
  int? id;
  String? status;
  String? title;
  String? icon;
  late bool selected;

  ActiveSkillsModel({this.id, this.status, this.title, this.icon});

  ActiveSkillsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    title = json['title'];
    icon = json['icon'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['title'] = title;
    data['icon'] = icon;
    return data;
  }
}
