class OrderModels {
  int? id;
  String? invoice;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  int? districtId;
  int? citieId;
  int? subtotal;
  int? cost;
  String? shipping;
  String? status;
  String? trackingNumber;
  String? ref;
  int? refStatus;
  String? createdAt;
  String? updatedAt;

  OrderModels(
      {this.id,
      this.invoice,
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
      this.trackingNumber,
      this.ref,
      this.refStatus,
      this.createdAt,
      this.updatedAt});

  OrderModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    trackingNumber = json['tracking_number'];
    ref = json['ref'];
    refStatus = json['ref_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['tracking_number'] = this.trackingNumber;
    data['ref'] = this.ref;
    data['ref_status'] = this.refStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
