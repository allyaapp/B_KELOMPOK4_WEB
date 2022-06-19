import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:blackshop/providers/CartProvider.dart';
import 'package:blackshop/providers/OrderProvider.dart';
import 'package:flutter/material.dart';
import 'package:blackshop/utils/CustomTextStyle.dart';
import 'package:blackshop/utils/CustomUtils.dart';
import 'package:blackshop/models/CartModels.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

// import 'package:badges/badges.dart';

import 'CheckOutPage.dart';

class UploadProofPembayaran extends StatefulWidget {
  // final CartModels cartModels;
  // UploadProofPembayaran(this.cartModels);
  @override
  _UploadProofPembayaranState createState() => _UploadProofPembayaranState();
}

class _UploadProofPembayaranState extends State<UploadProofPembayaran> {
  // addCart() async {
  //   var url = Uri.parse("http://127.0.0.1:8000/api/cart?id_customer=9");
  //   final response = await http.get
  // }

  // counter() async{
  // CartProvider cartProvider = Provider.of<CartProvider>(context);
  // int _counter = cartProvider.;

  // }
  // bool showRaisedButtonBadge = true;
  late SharedPreferences sharedPreferences;
  int id = 0;
  String name = "";
  String phone_number = "";
  String address = "";
  int citie_id = 0;
  String code = "";
  String nameKurir = "";
  String service = "";
  String description = "";
  String value = "";
  int price = 0;
  String etd = "";
  bool loading = true;

  List<PlatformFile>? image;
  // File? uploadimage;

  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        id = sharedPreferences.getInt("id")!;
        name = sharedPreferences.getString("name")!;
      });
    }
  }

  void _imagepicker() async {
    image = (await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: false,
            allowedExtensions: null))
        ?.files;
    print('Image Picker : ${image!.first.path}');
  }

  void _uploadImage() async {
    var uri = Uri.parse(
        'https://cdd9-180-253-162-136.ap.ngrok.io/api/checkout/payment/');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'invoice': "xCCn-1655510312",
      'order_id': 23,
      'name': name,
      'transfer_to': "082228905435",
      'amount': 57000,
      // 'proof': request.send(),
    });
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
        'proof', image!.first.path.toString()));
    request.fields["invoice"] = "xCCn-1655510312";
    request.fields["order_id"] = "23";
    request.fields["name"] = name;
    request.fields["transfer_to"] = "082228905435";
    request.fields["amount"] = "57000";
    var response = await request
        .send()
        .then((result) => http.Response.fromStream(result).then((response) {
              if (response.statusCode == 202) {
                print(response.body);
              } else {
                print("Error during connection to server");
              }
            }));
  }

  // Future<void> getImage(ImageSource media) async {
  //   var img = await picker.pickImage(source: media);

  //   setState(() {
  //     image = img;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text("Verification Successfully"),
      backgroundColor: Colors.green,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: (Text(
          "Payment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            fontFamily: 'sans-serif-light',
            color: Color.fromRGBO(1, 38, 0, 1),
          ),
        )
            // margin: const EdgeInsets.only(left: 12, top: 12),
            ),
        // Text(
        //   "Payment",
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 18.0,
        //     fontFamily: 'sans-serif-light',
        //     color: Color.fromRGBO(1, 38, 0, 1),
        //   ),
        // ),
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              // createHeader(),
              image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          // File(image!.first.path),
                          File(image!.first.path.toString()),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : Text(
                      "No Image",
                      style: TextStyle(fontSize: 20),
                    ),
              ElevatedButton(
                  onPressed: () {
                    _imagepicker();
                  },
                  child: Text("Choose image payment")),
              ElevatedButton(
                  onPressed: () async {
                    _uploadImage();
                    // if (await orderProvider.updateOrder(id: 23)) {
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // }
                  },
                  child: Text("Upload proof of payment"))
              // createSubTitle(),
              // createCartList(),
              // footer(context)
            ],
          );
        },
      ),
    );
  }

  footer(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    int total = 0;
    for (int i = 0; i < cartProvider.carts.length; i++) {
      total += (cartProvider.carts[i].cartPrice! * cartProvider.carts[i].qty!);
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.black, fontSize: 12),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Text(
                  total.toString(),
                  // "Rp12000",
                  // cartProvider.carts[0].cartPrice.toString(),
                  style: CustomTextStyle.textFormFieldBlack
                      .copyWith(color: Colors.black, fontSize: 13),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 8, width: 0),
          RaisedButton(
            onPressed: () {
              // ongkosKirim();
              Navigator.pushNamed(context, '/checkout');
            },
            color: Colors.green,
            padding:
                const EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Checkout",
              style: CustomTextStyle.textFormFieldSemiBold
                  .copyWith(color: Colors.white),
            ),
          ),
          Utils.getSizedBox(height: 8, width: 0),
        ],
      ),
      margin: const EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Column(
      children: <Widget>[
        Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          // height: 50.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      iconSize: 22.0,
                      onPressed: () {
                        // Navigator.of(context).asd(context, '/home');
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 14.0),
                      child: Text(
                        "Payment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: 'sans-serif-light',
                          color: Color.fromRGBO(1, 38, 0, 1),
                        ),
                      ),
                      // margin: const EdgeInsets.only(left: 12, top: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  createSubTitle() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total (" + cartProvider.carts.length.toString() + ") Item",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.black),
      ),
      margin: const EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList() {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(cartProvider.carts[position]);
      },
      itemCount: cartProvider.carts.length,
    );
  }

  createCartListItem(CartModels cart) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(229, 229, 229, 1),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://c43e-180-253-161-138.ap.ngrok.io/storage/products/" +
                              cart.product!.image.toString(),
                        ),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 8, top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // "Keripik Kaca",
                              cart.product!.name.toString(),
                              maxLines: 2,
                              softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 14),
                            ),
                            Text(
                              // "Rp6000",
                              cart.product!.price.toString(),
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 6, width: 0),
                      // Text(
                      //   "Green M",
                      //   style: CustomTextStyle.textFormFieldRegular
                      //       .copyWith(color: Colors.grey, fontSize: 14),
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(196, 196, 196, 1),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      cart.qty.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              // "Rp12000",
                              (cart.cartPrice! * cart.qty!).toString(),
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
        //     width: 24,
        //     height: 24,
        //     alignment: Alignment.center,
        //     margin: EdgeInsets.only(right: 10, top: 8),
        //     child: Icon(
        //       Icons.close,
        //       color: Colors.white,
        //       size: 20,
        //     ),
        //     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.green),
        //   ),
        // )
      ],
    );
  }
}
