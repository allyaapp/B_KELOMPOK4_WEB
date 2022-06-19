class CheckoutModel {
  String? invoice;
  int? customerId;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  int? districtId;
  int? citieId;
  String? subtotal;
  String? cost;
  String? shipping;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  CheckoutModel(
      {this.invoice,
      this.customerId,
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.districtId,
      this.citieId,
      this.subtotal,
      this.cost,
      this.shipping,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    invoice = json['invoice'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    districtId = json['district_id'];
    citieId = json['citie_id'];
    subtotal = json['subtotal'];
    cost = json['cost'];
    shipping = json['shipping'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice'] = this.invoice;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['district_id'] = this.districtId;
    data['citie_id'] = this.citieId;
    data['subtotal'] = this.subtotal;
    data['cost'] = this.cost;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
