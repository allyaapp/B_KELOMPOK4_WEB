import 'package:blackshop/models/ProductModels.dart';

class DetailCategoryModels {
  int? id;
  String? image;
  String? name;
  int? parentId;
  String? slug;
  String? createdAt;
  String? updatedAt;
  List<ProductModels>? product;

  DetailCategoryModels({
    this.id,
    this.image,
    this.name,
    this.parentId,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  DetailCategoryModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    parentId = json['parent_id'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product']
        .map<ProductModels>((product) => ProductModels.fromJson(product))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = product?.map((product) => product.toJson()).toList();
    return data;
  }
}
