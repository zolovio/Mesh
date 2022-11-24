import 'dart:convert';

SkillModel skillModelFromJson(String str) =>
    SkillModel.fromJson(json.decode(str));

String skillModelToJson(SkillModel data) => json.encode(data.toJson());

class SkillModel {
  SkillModel({
    this.id,
    this.status,
    this.title,
    this.icon,
  });

  int? id;
  String? status;
  String? title;
  String? icon;

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        id: json["id"],
        status: json["status"],
        title: json["title"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "title": title,
        "icon": icon,
      };
}
