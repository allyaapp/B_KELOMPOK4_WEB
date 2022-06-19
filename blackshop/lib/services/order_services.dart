import 'dart:convert';
import 'package:blackshop/models/CheckOutModel.dart';
import 'package:blackshop/models/OrderModels.dart';
import 'package:http/http.dart' as http;
import 'package:blackshop/models/AddtoCartModels.dart';

class OrderService {
  String baseUrl = "https://cdd9-180-253-162-136.ap.ngrok.io/api";
  // var url = '$baseUrl/addtocart?customer_id=$id';

  Future<List<OrderModels>> getOrder({String? id}) async {
    var url = '$baseUrl/order?customer_id=$id&status=0';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    print('GET ORDER :' + response.body);

    if (response.statusCode == 202) {
      List data = jsonDecode(response.body)['data'];
      List<OrderModels> listOrders = [];
      for (var item in data) {
        listOrders.add(OrderModels.fromJson(item));
      }
      return listOrders;
    } else {
      throw Exception('Gagal Get Order!');
    }
  }

  Future<List<OrderModels>> getOrderDone({String? id}) async {
    var url = '$baseUrl/order?customer_id=$id&status=1';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    print('GET ORDER DONE : ' + response.body);

    if (response.statusCode == 202) {
      List data = jsonDecode(response.body)['data'];
      List<OrderModels> listOrdersDone = [];
      for (var item in data) {
        listOrdersDone.add(OrderModels.fromJson(item));
      }
      return listOrdersDone;
    } else {
      throw Exception('Gagal Get Order!');
    }
  }

  Future<CheckoutModel> addOrder({
    String? customerId,
    String? subtotal,
    String? cost,
    String? shipping,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'customer_id': customerId,
      'subtotal': subtotal,
      'cost': cost,
      'shipping': shipping,
    });
    print(body);

    var response = await http.post(Uri.parse('$baseUrl/checkout'),
        headers: headers, body: body);
    // print(response.body);
    if (response.statusCode == 202) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      CheckoutModel order = CheckoutModel.fromJson(data);
      return order;
    } else {
      throw Exception('Gagal Add Order!');
    }
  }

  Future<OrderModels> updateOrder({int? id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'id': id,
    });
    print(body);

    var response = await http.post(Uri.parse('$baseUrl/checkout/payment'),
        headers: headers, body: body);
    // print(response.body);
    if (response.statusCode == 202) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      OrderModels order = OrderModels.fromJson(data);
      return order;
    } else {
      throw Exception('Gagal Update Order!');
    }
  }
}
