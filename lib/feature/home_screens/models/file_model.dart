// To parse this JSON data, do
//
//     final fileModel = fileModelFromJson(jsonString);

import 'dart:convert';

FileModel fileModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String fileModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
  FileModel({
    required this.id,
    required this.storage,
    required this.filenameDisk,
    required this.filenameDownload,
    required this.title,
    required this.type,
    required this.folder,
    required this.uploadedBy,
    required this.uploadedOn,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.charset,
    required this.filesize,
    required this.width,
    required this.height,
    required this.duration,
    required this.embed,
    required this.description,
    required this.location,
    required this.tags,
    required this.metadata,
  });

  String? id;
  String? storage;
  String? filenameDisk;
  String? filenameDownload;
  String? title;
  String? type;
  dynamic folder;
  dynamic uploadedBy;
  DateTime? uploadedOn;
  dynamic modifiedBy;
  DateTime? modifiedOn;
  dynamic charset;
  String? filesize;
  int? width;
  int? height;
  dynamic duration;
  dynamic embed;
  dynamic description;
  dynamic location;
  dynamic tags;
  Metadata? metadata;

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        storage: json["storage"],
        filenameDisk: json["filename_disk"],
        filenameDownload: json["filename_download"],
        title: json["title"],
        type: json["type"],
        folder: json["folder"],
        uploadedBy: json["uploaded_by"],
        uploadedOn: json["uploaded_on"] == null
            ? null
            : DateTime.parse(json["uploaded_on"]),
        modifiedBy: json["modified_by"],
        modifiedOn: json["modified_on"] == null
            ? null
            : DateTime.parse(json["modified_on"]),
        charset: json["charset"],
        filesize: json["filesize"],
        width: json["width"],
        height: json["height"],
        duration: json["duration"],
        embed: json["embed"],
        description: json["description"],
        location: json["location"],
        tags: json["tags"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "storage": storage,
        "filename_disk": filenameDisk,
        "filename_download": filenameDownload,
        "title": title,
        "type": type,
        "folder": folder,
        "uploaded_by": uploadedBy,
        "uploaded_on": uploadedOn!.toIso8601String(),
        "modified_by": modifiedBy,
        "modified_on": modifiedOn!.toIso8601String(),
        "charset": charset,
        "filesize": filesize,
        "width": width,
        "height": height,
        "duration": duration,
        "embed": embed,
        "description": description,
        "location": location,
        "tags": tags,
        "metadata": metadata!.toJson(),
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
