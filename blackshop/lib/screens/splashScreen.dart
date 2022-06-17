import 'dart:async';

import 'package:blackshop/providers/CartProvider.dart';
import 'package:blackshop/providers/CategoryProvider.dart';
import 'package:blackshop/providers/DetailCategoryProvider.dart';
import 'package:blackshop/providers/ProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getInit();
    // Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, "/login"));
    // TODO: implement initState
    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    await Provider.of<CategoryProvider>(context, listen: false).getCategory();
    await Provider.of<DetailCategoryProvider>(context, listen: false)
        .getListCategory();
    // await Provider.of<CartProvider>(context, listen: false).getCart();
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/logo_login.png",
        height: 110.0,
        fit: BoxFit.cover,
      )),
    );
  }
}
