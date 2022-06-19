import 'package:blackshop/models/CategoryModels.dart';

class ProductModels {
  int? id;
  String? name;
  String? slug;
  String? categoryId;
  String? description;
  String? image;
  String? price;
  String? stock;
  String? weight;
  String? status;
  String? createdAt;
  String? updatedAt;
  CategoryModels? category;

  ProductModels({
    this.id,
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
    this.updatedAt,
    this.category,
  });

  ProductModels.fromJson(Map<String, dynamic> json) {
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
    category = json['category'] != null
        ? new CategoryModels.fromJson(json['category'])
        : null;
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
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}
