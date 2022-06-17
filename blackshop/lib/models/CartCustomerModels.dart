class CartCustomerModels {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  int? citieId;
  int? districtId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  CartCustomerModels(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.citieId,
      this.districtId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.profilePhotoUrl});

  CartCustomerModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    citieId = json['citie_id'];
    districtId = json['district_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['citie_id'] = this.citieId;
    data['district_id'] = this.districtId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
