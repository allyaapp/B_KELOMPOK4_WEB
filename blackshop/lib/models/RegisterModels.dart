class RegisterModels {
  Data? data;
  String? accessToken;
  String? tokenType;

  RegisterModels({this.data, this.accessToken, this.tokenType});

  RegisterModels.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? profilePhotoUrl;

  Data(
      {this.name,
      this.email,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.profilePhotoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
