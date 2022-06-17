import 'dart:convert';

import 'package:blackshop/models/ProductModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class SearchForm extends StatefulWidget {
  // const SearchForm({
  // Key? key,
  // }) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  late FocusNode myFocusNode;
  List<ProductModels> products = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    final response = await http
        .get(Uri.parse("https://a1bd-180-253-165-54.ap.ngrok.io/api/Product"));
    if (response.statusCode == 202) {
      final data = jsonDecode(response.body);
      setState(() {
        for (var i in data) {
          products.add(ProductModels.fromJson(i));
          loading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  // _searchName(String name) {
  //   if (name.isNotEmpty) {
  //     setState(() {
  //       list.clear();
  //       //melakukan perulangan/looping
  //       items.forEach((item) {
  //         //jika list data ada yang mengandung susunan huruf yang dicari
  //         //maka masukan ke dalam data list
  //         if (item.toLowerCase().contains(name.toLowerCase())) {
  //           list.add(item);
  //         }
  //       });
  //     });
  //   } else {
  //     setState(() {
  //       list.clear();
  //       list.addAll(items);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        focusNode: myFocusNode,
        onSaved: (value) {},
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Search items...",
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: SizedBox(
              width: 48,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: SvgPicture.asset("assets/icons/Filter.svg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
