import 'dart:convert';
import 'package:blackshop/models/RegisterModels.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  String baseUrl = "https://blackshop.ws-tif.com/api";
  Future<RegisterModels> register(
      {String? name, String? email, String? password}) async {
    var url = '$baseUrl/register';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    // print(response.body);

    if (response.statusCode == 202) {
      RegisterModels data = jsonDecode(response.body)['data'];
      // data.accessToken = jsonDecode(response.body)['accessToken'];
      // data.profile = jsonDecode(response.body)['data']['profile'];
      // AuthModels.fromJson(data);
      return data;
    } else {
      throw Exception('Gagal Register');
    }
  }
}
