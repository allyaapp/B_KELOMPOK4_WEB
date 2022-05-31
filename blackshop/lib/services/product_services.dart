import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blackshop/models/ProductModels.dart';

class ProductService{
  String baseUrl = "https://63fd-116-206-40-2.ap.ngrok.io/api";

  Future<List<ProductModels>> getProducts() async {
    var url = '$baseUrl/Product';
    var headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if(response.statusCode == 202){
      List data = jsonDecode(response.body)['data'];
      List<ProductModels> products = [];

      for(var item in data){
        products.add(ProductModels.fromJson(item));
      }

      return products;
    } else{
      throw Exception('Gagal Get Products!');
    }
  }
}