import 'package:blackshop/screens/login.dart';

class LoginAuth{
  String message;

  LoginAuth({required this.message});
  LoginAuth.fromJson(Map<String, dynamic> json, this.message){
    message = json['message'];
  }
}

