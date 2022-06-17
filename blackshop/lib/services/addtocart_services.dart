import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blackshop/models/AddtoCartModels.dart';

class AddtoCartService {
  String baseUrl = "https://c43e-180-253-161-138.ap.ngrok.io/api";
  // var url = '$baseUrl/addtocart?customer_id=$id';

  Future<AddtoCartModels> addCart({
    String? customerId,
    String? productId,
    String? cartPrice,
    String? cartWeight,
    // String? qty,
    // String? updatedAt,
    // String? createdAt,
    // int? id,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'customer_id': customerId,
      'product_id': productId,
      'cart_price': cartPrice,
      'cart_weight': cartWeight,
      // 'qty': qty,
      // 'updatedAt': updatedAt,
      // 'createdAt': createdAt,
      // 'id': id,
    });
    print(body);

    var response = await http.post(Uri.parse('$baseUrl/addtocart'),
        headers: headers, body: body);
    print(response.body);
    if (response.statusCode == 202) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      AddtoCartModels carts = AddtoCartModels.fromJson(data);
      return carts;
    } else {
      throw Exception('Gagal Add Cart!');
    }
  }
  // Future<List<AddtoCartModels>> addCart({String? id}) async {
  //   var url = '$baseUrl/addtocart?customer_id=$id';
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json'
  //   };
  //   final response = await http.post(Uri.parse(url), headers: headers);

  //   print(response.body);

  //   if (response.statusCode == 202) {
  //     List data = jsonDecode(response.body)['data'];
  //     List<AddtoCartModels> carts = [];
  //     for (var item in data) {
  //       carts.add(AddtoCartModels.fromJson(item));
  //     }
  //     return carts;
  //   } else {
  //     throw Exception('Gagal Add Cart!');
  //   }
  // }
}
