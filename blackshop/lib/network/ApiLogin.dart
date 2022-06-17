import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/LoginModels.dart';

class ApiLogin {
  Future loginUser(String _email, String _password) async {
    String baseUrl = "https://66f0-202-67-41-10.ap.ngrok.io/login";

    try {
      var response = await http.post(Uri.parse(baseUrl), body: {
        'email': _email,
        'password': _password,
      });
      var jsonResponse = jsonDecode(response.body);
      // return LoginAuth.fromJson();
    } catch (e) {
      return e;
    }
  }

  // Future userLogout
}
