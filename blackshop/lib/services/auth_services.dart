import 'dart:convert';
import 'package:blackshop/models/AuthModels.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = "https://blackshop.ws-tif.com/api";
  Future<AuthModels> masuk(String email, String password) async {
    var url = '$baseUrl/login';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    // print(response.body);

    if (response.statusCode == 202) {
      AuthModels data = jsonDecode(response.body)['data']['user'];
      data.token = jsonDecode(response.body)['data']['token'];
      data.profile = jsonDecode(response.body)['data']['profile'];
      // AuthModels.fromJson(data);
      return data;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
