class CategoryModels {
  int? id;
  String? name;
  Null? parentId;
  String? slug;
  String? createdAt;
  String? updatedAt;

  CategoryModels(
      {this.id,
      this.name,
      this.parentId,
      this.slug,
      this.createdAt,
      this.updatedAt});

  CategoryModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}