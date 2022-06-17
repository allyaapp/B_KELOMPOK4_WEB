class AddtoCartModels {
  int? code;
  String? message;
  Data? data;

  AddtoCartModels({this.code, this.message, this.data});

  AddtoCartModels.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? customerId;
  String? productId;
  String? cartPrice;
  String? cartWeight;
  String? qty;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.customerId,
      this.productId,
      this.cartPrice,
      this.cartWeight,
      this.qty,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    productId = json['product_id'];
    cartPrice = json['cart_price'];
    cartWeight = json['cart_weight'];
    qty = json['qty'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['cart_price'] = this.cartPrice;
    data['cart_weight'] = this.cartWeight;
    data['qty'] = this.qty;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
