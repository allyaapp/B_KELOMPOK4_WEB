import 'package:blackshop/models/AuthModels.dart';
import 'package:blackshop/models/CartCustomerModels.dart';
import 'package:blackshop/models/CartProductModels.dart';
import 'package:blackshop/models/ProductModels.dart';

class CartModels {
  int? id;
  int? customerId;
  int? productId;
  int? cartPrice;
  int? cartWeight;
  int? qty;
  int? status;
  String? createdAt;
  String? updatedAt;
  ProductModels? product;
  AuthModels? customer;

  CartModels(
      {this.id,
      this.customerId,
      this.productId,
      this.cartPrice,
      this.cartWeight,
      this.qty,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.customer});

  CartModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    cartPrice = json['cart_price'];
    cartWeight = json['cart_weight'];
    qty = json['qty'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = ProductModels.fromJson(json['product']);
    customer = AuthModels.fromJson(json['customer']);
    // product = json['product'] ;
    // customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['cart_price'] = this.cartPrice;
    data['cart_weight'] = this.cartWeight;
    data['qty'] = this.qty;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = this.product?.toJson();
    data['customer'] = this.customer?.toJson();
    // if (this.product != null) {
    // }
    // if (this.customer != null) {
    // }
    return data;
  }
}
