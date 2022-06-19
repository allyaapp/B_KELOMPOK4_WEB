import 'dart:convert';
import 'package:blackshop/LoginScreen.dart';
import 'package:blackshop/models/CartModels.dart';
import 'package:blackshop/providers/CartProvider.dart';
import 'package:blackshop/providers/OrderProvider.dart';
import 'package:blackshop/screens/HistoryPage.dart';
import 'package:blackshop/screens/UploadProofPembayaran.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:blackshop/utils/CustomTextStyle.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
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

  @override
  void initState() {
    ongkosKirim();
    getData();
    checkLoginStatus();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    if (mounted) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        id = sharedPreferences.getInt("id")!;
        name = sharedPreferences.getString("name")!;
        phone_number = sharedPreferences.getString("phone_number")!;
        address = sharedPreferences.getString("address")!;
        citie_id = sharedPreferences.getInt("citie_id")!;
      });
    }
  }

  ongkosKirim() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);
      int totalWeight = 0;
      for (int i = 0; i < cartProvider.carts.length; i++) {
        totalWeight += cartProvider.carts[i].cartWeight!;
      }
      final response = await http.post(
        url,
        body: {
          'origin': "252",
          'destination': sharedPreferences.getInt("citie_id")!.toString(),
          'weight': totalWeight.toString(),
          'courier': "jne",
        },
        headers: {
          'key': '69814309705ff72181423c2398d28c94',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Access-Control-Allow-Origin': '*',
          'Accept': 'application/json'
        },
      );
      // print(response.body);
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        code = data["rajaongkir"]["results"][0]['code'];
        nameKurir = data["rajaongkir"]["results"][0]['name'];
        service = data["rajaongkir"]["results"][0]['costs'][1]['service'];
        description =
            data["rajaongkir"]["results"][0]['costs'][1]['description'];
        value = data["rajaongkir"]["results"][0]['costs'][1]['cost'][0]['value']
            .toString();

        etd = data["rajaongkir"]["results"][0]['costs'][1]['cost'][0]['etd'];
      });
      setState(() {
        price = int.parse(value);
        loading = false;
      });
      print(etd);
    } catch (e) {
      print(e);
    }
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    int subtotal = 0;
    for (int i = 0; i < cartProvider.carts.length; i++) {
      subtotal +=
          (cartProvider.carts[i].cartPrice! * cartProvider.carts[i].qty!);
    }
    int cost = subtotal + price;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () async {
                await Provider.of<CartProvider>(context, listen: false)
                    .getCart(id: sharedPreferences.getInt("id").toString());
                Navigator.pushNamed(context, '/cart');
              }),
          title: Text(
            "Checkout",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'sans-serif-light',
              color: Color.fromRGBO(1, 38, 0, 1),
            ),
          ),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      selectedAddressSection(),
                      standardDelivery(),
                      checkoutItem(),
                      priceSection()
                    ],
                  ),
                ),
                flex: 90,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: RaisedButton(
                    onPressed: () async {
                      if (await orderProvider.addOrder(
                          customerId: id.toString(),
                          shipping: value,
                          subtotal: subtotal.toString(),
                          cost: cost.toString())) {
                        // print('okok');
                        showThankYouBottomSheet(context);
                      } else {
                        Text("Place Order Failed");
                        // print('false');
                      }
                      /*Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => OrderPlacePage()));*/
                    },
                    child: Text(
                      "Place Order",
                      style: CustomTextStyle.textFormFieldMedium.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                ),
                flex: 10,
              )
            ],
          );
        }),
      ),
    );
  }

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState?.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/icons/ic_thank_you.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: CustomTextStyle.textFormFieldMedium.copyWith(
                                fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      onPressed: () {
                        // Navigator.pushReplacementNamed(context, "/history");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HistoryPage()),
                        );
                      },
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Payment Confirmation",
                        style: CustomTextStyle.textFormFieldMedium
                            .copyWith(color: Colors.white),
                      ),
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  selectedAddressSection() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    // "Anton Sebrianto (Default)",
                    name,
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(fontSize: 14),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Text(
                      "HOME",
                      style: CustomTextStyle.textFormFieldBlack.copyWith(
                          color: Colors.indigoAccent.shade200, fontSize: 8),
                    ),
                  )
                ],
              ),
              // createAddressText("Kaliurang Green Garden Regency", 16),
              createAddressText(address, 16),
              // createAddressText("Sumbersari", 6),
              // createAddressText("Jember", 6),
              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text:
                          // "082228905435",
                          phone_number,
                      style: CustomTextStyle.textFormFieldBold
                          .copyWith(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              addressAction()
            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium
            .copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Edit / Change",
              style: CustomTextStyle.textFormFieldSemiBold
                  .copyWith(fontSize: 12, color: Colors.indigo.shade700),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 3,
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          Spacer(
            flex: 3,
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Add New Address",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(fontSize: 12, color: Colors.indigo.shade700)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  standardDelivery() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border:
              Border.all(color: Colors.tealAccent.withOpacity(0.4), width: 1),
          color: Colors.tealAccent.withOpacity(0.2)),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {},
            activeColor: Colors.tealAccent.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                // "Standard Delivery",
                nameKurir,
                style: CustomTextStyle.textFormFieldMedium.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                // "Get it by 10 June - 12 June | Free Delivery",
                service + " | " + etd + " days",
                style: CustomTextStyle.textFormFieldMedium.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  checkoutItem() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return checkoutListItem();
            },
            itemCount: 1,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem() {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: cartProvider.carts
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: NetworkImage(
                          "https://cdd9-180-253-162-136.ap.ngrok.io/storage/products/" +
                              e.product!.image.toString(),
                        ),
                        width: 35,
                        height: 45,
                        fit: BoxFit.fitHeight,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(e.product!.name.toString()),
                    // RichText(
                    //   text: TextSpan(children: [
                    //     TextSpan(
                    //         text: "Estimated Delivery : ",
                    //         style: CustomTextStyle.textFormFieldMedium
                    //             .copyWith(fontSize: 12)),
                    //     TextSpan(
                    //         text: loading ? 'loading...' : etd,
                    //         style: CustomTextStyle.textFormFieldMedium.copyWith(
                    //             fontSize: 12, fontWeight: FontWeight.w600))
                    //   ]),
                    // )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  priceSection() {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    int total = 0;
    for (int i = 0; i < cartProvider.carts.length; i++) {
      total += (cartProvider.carts[i].cartPrice! * cartProvider.carts[i].qty!);
    }
    int fee = 2000;
    int order_total = total + fee + price;
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
                style: CustomTextStyle.textFormFieldMedium.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              createPriceItem("Total", getFormattedCurrency(total, 2),
                  Colors.grey.shade700),
              createPriceItem("Aplication Fee", getFormattedCurrency(fee, 2),
                  Colors.grey.shade700),
              // createPriceItem(
              //     "Tax", getFormattedCurrency(96), Colors.grey.shade700),
              createPriceItem("Delivery Charges",
                  getFormattedCurrency(price, 2), Colors.teal.shade300),
              // createPriceItem("Order Total", getFormattedCurrency(14000, 2),
              //     Colors.grey.shade700),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Order Total",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(color: Colors.black, fontSize: 12),
                  ),
                  Text(
                    getFormattedCurrency(order_total, 2),
                    style: CustomTextStyle.textFormFieldMedium
                        .copyWith(color: Colors.black, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static String getFormattedCurrency(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
