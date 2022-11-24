class ErrorResModel {
  List<Errors>? errors;

  ErrorResModel({this.errors});

  ErrorResModel.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  String? message;
  Extensions? extensions;

  Errors({this.message, this.extensions});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    extensions = json['extensions'] != null
        ? Extensions.fromJson(json['extensions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (extensions != null) {
      data['extensions'] = extensions!.toJson();
    }
    return data;
  }
}

class Extensions {
  String? code;
  String? collection;
  String? field;
  String? invalid;

  Extensions({this.code, this.collection, this.field, this.invalid});

  Extensions.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    collection = json['collection'];
    field = json['field'];
    invalid = json['invalid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['collection'] = collection;
    data['field'] = field;
    data['invalid'] = invalid;
    return data;
  }
}
