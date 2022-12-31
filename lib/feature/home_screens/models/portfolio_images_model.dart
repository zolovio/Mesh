class PortfolioImageModel {
  List<PortfolioImage>? data;

  PortfolioImageModel({this.data});

  PortfolioImageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PortfolioImage>[];
      json['data'].forEach((v) {
        data!.add(new PortfolioImage.fromJson(v));
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

class PortfolioImage {
  String? id;
  String? userCreated;
  String? dateCreated;
  String? image;

  PortfolioImage({this.id, this.userCreated, this.dateCreated, this.image});

  PortfolioImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCreated = json['user_created'];
    dateCreated = json['date_created'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_created'] = this.userCreated;
    data['date_created'] = this.dateCreated;
    data['image'] = this.image;
    return data;
  }
}
