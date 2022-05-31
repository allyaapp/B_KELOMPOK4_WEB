import 'dart:convert';
import 'package:http/http.dart'as http;

import '../models/LoginModels.dart';

class ApiLogin{
  Future loginUser(String _email, String _password) async{
    String baseUrl = "https://70fa-180-253-167-167.ap.ngrok.io/Aplikasi_Penjualan/login";

    try{
      var response = await http.post(Uri.parse(baseUrl), body:{
        'email':_email,
        'password':_password,
      }
      );
      var jsonResponse = jsonDecode(response.body);
      // return LoginAuth.fromJson();
    } catch(e){
      return e;
    }
  }

  // Future userLogout
}