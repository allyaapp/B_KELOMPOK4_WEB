import 'dart:convert';
import 'package:blackshop/models/DetailCategoryModels.dart';
import 'package:http/http.dart' as http;

class DetailCategoryServices {
  String baseUrl = "https://c43e-180-253-161-138.ap.ngrok.io/api";

  Future<List<DetailCategoryModels>> getListCategory({String? slug}) async {
    var url = '$baseUrl/detailcategories?slug=$slug';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 202) {
      List data = jsonDecode(response.body)['data']['data'];
      List<DetailCategoryModels> category = [];

      for (var item in data) {
        category.add(DetailCategoryModels.fromJson(item));
      }

      return category;
    } else {
      throw Exception('Gagal Get List Category!');
    }
  }
}
