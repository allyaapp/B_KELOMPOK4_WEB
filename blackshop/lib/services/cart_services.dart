import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blackshop/models/CartModels.dart';

class CartService {
  String baseUrl = "https://c43e-180-253-161-138.ap.ngrok.io/api";

  Future<List<CartModels>> getCart({String? id}) async {
    var url = '$baseUrl/cart?id_customer=$id';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 202) {
      List data = jsonDecode(response.body)['data'];
      List<CartModels> carts = [];
      for (var item in data) {
        carts.add(CartModels.fromJson(item));
      }
      return carts;
    } else {
      throw Exception('Gagal Get Cart!');
    }
  }
}
