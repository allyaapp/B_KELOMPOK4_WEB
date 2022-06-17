// import 'package:blackshop/models/AuthModels.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';

// class UserPreferences {
//   Future<bool> saveUser(User user) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     prefs.setInt("userId", user.id!.toInt());
//     prefs.setString("name", user.name.toString());
//     prefs.setString("email", user.email.toString());
//     // prefs.setString("phone", user.phone);
//     prefs.setString("level", user.level.toString());
//     // prefs.setString("token", AuthModels(data: Data()).toString());
//     // prefs.setString("renewalToken", user.renewalToken);

//     return prefs.commit();
//   }

//   Future<User> getUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     int? userId = prefs.getInt("userId");
//     String? name = prefs.getString("name");
//     String? email = prefs.getString("email");
//     // String? phone = prefs.getString("phone");
//     String? level = prefs.getString("level");
//     // String? token = prefs.getString("token");
//     // String? renewalToken = prefs.getString("renewalToken");

//     return User(
//       id: userId,
//       name: name,
//       email: email,
//       // phone: phone,
//       level: level,
//     );
//     // token: token,
//     // renewalToken: renewalToken);
//   }

//   void removeUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     prefs.remove("name");
//     prefs.remove("email");
//     // prefs.remove("phone");
//     prefs.remove("level");
//     prefs.remove("token");
//   }

//   // Future<String> getToken(args) async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String token = prefs.getString("token");
//   //   return token;
//   // }
// }
