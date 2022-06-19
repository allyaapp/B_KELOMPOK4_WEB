import 'dart:convert';
import 'dart:ui';
import 'package:blackshop/models/LoginModels.dart';
import 'package:blackshop/network/ApiLogin.dart';
import 'package:blackshop/providers/AddtoCartProvider.dart';
import 'package:blackshop/providers/CartProvider.dart';
import 'package:blackshop/providers/OrderProvider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:blackshop/utils/SharedPreferences.dart';
import 'package:blackshop/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RegisterScreen.dart';
// import 'package:blackshop/providers/AuthProvider.dart';
import 'package:blackshop/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:blackshop/models/AuthModels.dart';

class LoginScreen extends StatefulWidget {
  // final AuthModels auth;
  // LoginScreen(this.auth);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({Key? key}) : super(key: key);
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  // final UserProvider _userProvider = UserProvider();

  // var email, password;

  bool isLoading = false;

  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late ScaffoldMessengerState scaffoldMessenger;

  bool _secureText = true;

  // final ApiLogin _loginAuth;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  handleLogin(String email, String password) async {
    Map data = {
      'email': email,
      'password': password,
    };

    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http
        .post(Uri.parse("https://blackshop.ws-tif.com/api/login"), body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print(response.body);
      setState(() {
        isLoading = false;
        sharedPreferences.setString(
            "token", jsonData['data']['auth-token']['plainTextToken']);
        sharedPreferences.setInt("id", jsonData['data']['user']['id']);
        sharedPreferences.setString("name", jsonData['data']['user']['name']);
        sharedPreferences.setString("email", jsonData['data']['user']['email']);
        sharedPreferences.setString(
            "citie_id", jsonData['data']['user']['citie_id']);
        sharedPreferences.setString("profile", jsonData['data']['profile']);
        sharedPreferences.setString(
            "phone_number", jsonData['data']['user']['phone_number']);
        sharedPreferences.setString(
            "address", jsonData['data']['user']['address']);
        Provider.of<CartProvider>(context, listen: false)
            .getCart(id: jsonData['data']['user']['id'].toString());
        Provider.of<OrderProvider>(context, listen: false)
            .getOrder(id: jsonData['data']['user']['id'].toString());
        Provider.of<OrderProvider>(context, listen: false)
            .getOrderDone(id: jsonData['data']['user']['id'].toString());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
      });
    } else {
      print(response.body);
    }

    // try {
    //   UserProvider userProvider = Provider.of(context).login(
    //       email: _emailController.text.toString().trim(),
    //       password: _passwordController.text);
    //   Get.to(() => HomeScreen());
    // } catch (e) {
    //   print(e);
    //   SnackBar(
    //     content: Text(e.toString()),
    //   );
    // }
    // ProductProvider productProvider = Provider.of<ProductProvider>(context);
    // AuthProvider authProvider = Provider.of<AuthProvider>(context).login({String? _emailController, String? _passwordController});
    //   print("object");
    //   AuthModels userProvider =
    //       Provider.of(context).login(_emailController, _passwordController);
    //   if (userProvider == true) {
    //     Navigator.pushNamed(context, '/home');
    //   } else {
    //     print("ktnl");
    //   }
    // }
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);
    // var loading = Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     CircularProgressIndicator(),
    //     Text(" Authenticating ... Please wait")
    //   ],
    // );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 10),
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
                                child:
                                    const Icon(Icons.account_circle_outlined),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  autofocus: false,
                                  controller: _emailController,
                                  decoration: const InputDecoration.collapsed(

                                      // border: OutlineInputBorder(
                                      //     borderRadius: BorderRadius.circular(20)),
                                      hintText: "Email"),
                                  // validator: (emailValue) {
                                  //   if (emailValue == null) {
                                  //     return 'Please enter your username';
                                  //   }
                                  //   email = emailValue;
                                  //   return null;
                                  // }
                                ),
                              ),
                            ],
                          )
                          // ),
                          ),
                      const SizedBox(
                        height: 22,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 0),
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
                                  controller: _passwordController,
                                  // keyboardType: TextInputType.text,
                                  obscureText: _secureText,
                                  decoration: const InputDecoration.collapsed(
                                      // prefixIcon: Icon(Icons.key),
                                      //
                                      // suffixIcon:
                                      // border: OutlineInputBorder(
                                      //     borderRadius: BorderRadius.circular(20)),
                                      hintText: "Password"),
                                  // validator: (passwordValue) {
                                  //   if (passwordValue == null) {
                                  //     return 'Please enter your password';
                                  //   }
                                  //   password = passwordValue;
                                  //   return null;
                                  // }
                                ),
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
                            setState(() {
                              isLoading = true;
                            });
                            handleLogin(_emailController.text,
                                _passwordController.text);
                            // UserProvider userProvider = Provider.of(context)
                            //     .login('athal@gmail.com', '12345678');
                            // print("object");
                            // if (userProvider == true) {
                            //   Navigator.pushNamed(context, '/home');
                            // } else {
                            //   print("ktnl");
                            // }
                            // ApiLogin(_loginAuth));
                            // _loginAuth;
                            // child:
                            // auth.loggedInStatus == Status.Authenticating
                            //     ? loading
                            //     : AuthProvider().login("athal@gmail.com", "12345678");
                            // Navigator.pushNamed(context, '/home');
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
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color.fromRGBO(1, 38, 0, 1),
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(vertical: 18),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ));
// var doLogin = () {
//   final form = _formKey.currentState;

//   if (form!.validate()) {
//     form.save();

//     final Future<Map<String, dynamic>> successfulMessage =
//         auth.login(username, password);

//     successfulMessage.then((response) {
//       if (response['status']) {
//         User user = response['user'];
//         Provider.of<UserProvider>(context, listen: false).setUser(user);
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         //       Flushbar(
//         //         title: "Failed Login",
//         //         message: response['message']['message'].toString(),
//         //         duration: Duration(seconds: 3),
//         //       ).show(context);
//         //     }
//         //   });
//         // } else {
//         //   print("form is invalid");
//       }
//     });
