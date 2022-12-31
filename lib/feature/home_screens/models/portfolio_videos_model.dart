class PortfolioVideosModel {
  List<PortfolioVideo>? data;

  PortfolioVideosModel({this.data});

  PortfolioVideosModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PortfolioVideo>[];
      json['data'].forEach((v) {
        data!.add(new PortfolioVideo.fromJson(v));
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

class PortfolioVideo {
  String? id;
  String? userCreated;
  String? dateCreated;
  String? video;

  PortfolioVideo({this.id, this.userCreated, this.dateCreated, this.video});

  PortfolioVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCreated = json['user_created'];
    dateCreated = json['date_created'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_created'] = this.userCreated;
    data['date_created'] = this.dateCreated;
    data['video'] = this.video;
    return data;
  }
}
