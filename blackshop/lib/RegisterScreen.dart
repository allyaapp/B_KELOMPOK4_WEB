// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blackshop/LoginScreen.dart';
import 'package:blackshop/screens/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _secureText = true;
  var password, confirmPassword;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // registerSubmit() async {
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: _emailController.text.toString().trim(),
  //         password: _passwordController.text);
  //   } catch (e) {
  //     print(e);
  //     SnackBar(content: Text(e.toString()));
  //   }
  // }

  // loginSubmit() async {
  //   try {
  //     _firebaseAuth
  //         .signInWithEmailAndPassword(
  //             email: _emailController.text, password: _passwordController.text)
  //         .then((value) => Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(builder: (context) => HomeScreen())));
  //   } catch (e) {
  //     print(e);
  //     SnackBar(content: Text(e.toString()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: <Widget>[
            // Container(
            //   alignment: Alignment.topLeft,
            //   // padding: EdgeInsets.all(10),
            //   margin: const EdgeInsets.only(top: 40),
            //   child: TextButton(
            //     child: Text(
            //       "Sign Up",
            //       style: TextStyle(
            //           fontSize: 25,
            //           fontFamily: 'Roboto-Bold',
            //           fontWeight: FontWeight.w700,
            //           color: Colors.black),
            //     ),
            //     onPressed: () {
            //       // LoginScreen();
            //
            //     },
            //   ),
            // ),
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Complete the data below to create an account !!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto-Medium",
                    fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              // height: 50,
              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
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
              // padding: EdgeInsets.all(10),
              child: Expanded(
                child: TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration.collapsed(
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20)),
                      hintText: "Full Name"),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              // height: 50,
              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
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
                child: TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration.collapsed(
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20)),
                      hintText: "Phone"),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              // height: 50,
              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
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
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration.collapsed(
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20)),
                      hintText: "E-Mail"),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              // height: 50,
              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
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
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration.collapsed(
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20)),
                      hintText: "Username"),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              // height: 50,
              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              // height: 50,
              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                            hintText: "Confirm Password"),
                        validator: (confirmPasswordValue) {
                          if (confirmPasswordValue == null) {
                            return 'Please confirm your password';
                          }
                          confirmPassword = confirmPasswordValue;
                          return null;
                        }),
                  ),
                  IconButton(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 20,
                    onPressed: showHide,
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
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
                      "SIGN UP",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                )),
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
