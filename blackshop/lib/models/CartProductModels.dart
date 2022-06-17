class CartProductModels {
  int? id;
  String? name;
  String? slug;
  int? categoryId;
  String? description;
  String? image;
  int? price;
  int? stock;
  int? weight;
  int? status;
  String? createdAt;
  String? updatedAt;

  CartProductModels(
      {this.id,
      this.name,
      this.slug,
      this.categoryId,
      this.description,
      this.image,
      this.price,
      this.stock,
      this.weight,
      this.status,
      this.createdAt,
      this.updatedAt});

  CartProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    categoryId = json['category_id'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    stock = json['stock'];
    weight = json['weight'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['weight'] = this.weight;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
