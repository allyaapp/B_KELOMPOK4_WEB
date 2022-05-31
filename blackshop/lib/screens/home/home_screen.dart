import 'dart:convert';

import 'package:blackshop/providers/ProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blackshop/constants.dart';
import 'package:provider/provider.dart';

import '../DrawerScreen.dart';
import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';
import 'package:blackshop/screens/profile.dart';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List _product = [];
  // void getData() async {
  //   http.Response res =
  //       await http.get(Uri.parse('http://127.0.0.1:8000/api/Product'));
  //   if (res.statusCode == 202) {
  //     setState(() {
  //       var data =jsonDecode(res.body);
  //       _product = data['data'];
  //       // print(data['data']);
  //       // if (mounted) {
  //       //   _product = data['data'];
  //       // }
  //     });
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    // getData();
    // print(_product);
    super.initState();
  }

  int _counter = 0;
  bool showRaisedButtonBadge = true;
  @override
  Widget build(BuildContext context) {
    // print(_product);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => ProfilePage()));
        //   },
        //   icon: SvgPicture.asset("assets/icons/menu.svg"),
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/Location.svg"),
            const SizedBox(width: defaultPadding / 2),
            Text(
              "Jember",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          _shoppingCartBadge(),
          // IconButton(
          //   // icon: SvgPicture.asset("assets/icons/Notification.svg"),
          //   padding: const EdgeInsets.only(right: 8),
          //   icon: const Icon(Icons.shopping_cart),
          //   iconSize: 20,
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/cart');
          //   },

          // ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(defaultPadding),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
              new TextEditingController().clear();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Text(
                "Your style",
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: SearchForm(),
              ),
              const Categories(),
              const NewArrivalProducts(),
              const PopularProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return Badge(
      badgeColor: Colors.white,
      position: BadgePosition.topStart(top: 0, start: -1),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        _counter.toString(),
        style: TextStyle(color: Colors.black),
      ),
      child: IconButton(
          padding: const EdgeInsets.only(right: 8),
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
          iconSize: 20,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          }),
    );
  }
}
