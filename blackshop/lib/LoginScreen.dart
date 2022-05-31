import 'dart:convert';
import 'dart:ui';
import 'package:blackshop/models/LoginModels.dart';
import 'package:blackshop/network/ApiLogin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:blackshop/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RegisterScreen.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  var username, password;
  bool isLoading = false;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScaffoldMessengerState scaffoldMessenger;
  bool _secureText = true;

  final ApiLogin _loginAuth;
  LoginScreen(this._loginAuth);

  showHide() {
    // setState(() {
      _secureText = !_secureText;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 40),
              child: Image.asset(
                "assets/logo_login.png",
                height: 110,
                width: 110,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Already have an account?",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto-Bold",
                    fontSize: 25),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: const Text(
                "            If you want to join us \nPlease enter your personal data !!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto-Medium",
                    fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(color: Colors.black),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: const Icon(Icons.account_circle_outlined),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                              // controller: _usernameController,
                              decoration: const InputDecoration.collapsed(

                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20)),
                                  hintText: "Username"),
                              validator: (usernameValue) {
                                if (usernameValue == null) {
                                  return 'Please enter your username';
                                }
                                username = usernameValue;
                                return null;
                              }),
                        ),
                      ],
                    )
                    // ),
                    ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(color: Colors.black),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.key),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                              // controller: _passwordController,
                              // keyboardType: TextInputType.text,
                              obscureText: _secureText,
                              decoration: const InputDecoration.collapsed(
                                  // prefixIcon: Icon(Icons.key),
                                  //
                                  // suffixIcon:
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(20)),
                                  hintText: "Password"),
                              validator: (passwordValue) {
                                if (passwordValue == null) {
                                  return 'Please enter your password';
                                }
                                password = passwordValue;
                                return null;
                              }),
                        ),
                        IconButton(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 20,
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ],
                    )
                    // ),
                    ),
              ],
            ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   child: TextFormField(
            //       // controller: _passwordController,
            //       keyboardType: TextInputType.text,
            //       obscureText: _secureText,
            //       decoration: InputDecoration(
            //           prefixIcon: Icon(Icons.key),
            //           //
            //           suffixIcon: IconButton(
            //             onPressed: showHide,
            //             icon: Icon(_secureText
            //                 ? Icons.visibility_off
            //                 : Icons.visibility),
            //           ),
            //           border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(20)),
            //           labelText: "Password"),
            //       validator: (passwordValue) {
            //         if (passwordValue == null) {
            //           return 'Please enter your password';
            //         }
            //         password = passwordValue;
            //         return null;
            //       }),
            // ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto-Medium',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  onPressed: () {}
                  // forgotPassword(),
                  ),
            ),
            // Container(
            //   height: 50,
            //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0)
            //   child: ElevatedButton(
            //     style: raisedButtonStyle,
            //     child: Text("Register"),
            //     onPressed: () {
            //       // registerSubmit();
            //     },
            //   ),
            // ),
            const SizedBox(height: 10),
            Container(
                // height: 50,
                // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(color: Colors.black),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Expanded(
                  child: ElevatedButton(
                    style: raisedButtonStyle,
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      // ApiLogin(_loginAuth));
                      // _loginAuth;
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                )),
            const SizedBox(height: 30),
            Container(
                // padding: EdgeInsets.fromLTRB(10, 30, 30, 30),
                // alignment: AlignmentDirectional.center,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(108, 108, 108, 1)),
                ),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                    child: const Text(
                      "Sign Up Now",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(1, 38, 0, 1)),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    }),
              ],
            )),
            // Container(
            //   padding: EdgeInsets.fromLTRB(10, 30, 30, 30),
            //   // alignment: AlignmentDirectional.centerEnd,
            //   child: TextButton(
            //       child: Text(
            //         "Sign Up Now",
            //         style: TextStyle(
            //             fontSize: 18,
            //             fontFamily: 'Roboto-Bold',
            //             fontWeight: FontWeight.w700,
            //             color: Color.fromRGBO(1, 38, 0, 1)),
            //       ),
            //       onPressed: () {}
            //       // signUp(),
            //       ),
            // ),
          ],
        ),
      ),
    );
}
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color.fromRGBO(1, 38, 0, 1),
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(vertical: 18),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ));
}