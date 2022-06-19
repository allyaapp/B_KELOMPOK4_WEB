import 'dart:convert';
import 'package:blackshop/models/CategoryModels.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  String baseUrl = "https://cdd9-180-253-162-136.ap.ngrok.io/api";

  Future<List<CategoryModels>> getCategory() async {
    var url = '$baseUrl/categories';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 202) {
      List data = jsonDecode(response.body)['data'];
      List<CategoryModels> category = [];

      for (var item in data) {
        category.add(CategoryModels.fromJson(item));
      }

      return category;
    } else {
      throw Exception('Gagal Get Category!');
    }
  }
}
