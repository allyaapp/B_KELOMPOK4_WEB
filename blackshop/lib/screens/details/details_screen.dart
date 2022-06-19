import 'package:blackshop/providers/AddtoCartProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:blackshop/constants.dart';
import 'package:blackshop/models/Product.dart';
// import 'package:badges/badges.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ProductModels.dart';
import 'components/color_dot.dart';

class DetailsScreen extends StatefulWidget {
  // const DetailsScreen({Key? key}) : super(key: key);
  final ProductModels product;
  DetailsScreen(this.product);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late SharedPreferences sharedPreferences;
  String customerId = "";

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
        customerId = sharedPreferences.getInt("id").toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AddtoCartProvider addtocartProvider =
        Provider.of<AddtoCartProvider>(context);
    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text("Product added to cart successfully"),
      backgroundColor: Colors.green,
    );
    // print(widget.product.image);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          // _shoppingCartBadge(),
          // IconButton(
          //   onPressed: () {},
          //   icon: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     child: SvgPicture.asset(
          //       "assets/icons/Heart.svg",
          //       height: 20,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Image.network(
              "https://cdd9-180-253-162-136.ap.ngrok.io/storage/products/" +
                  widget.product.image.toString(),
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: defaultPadding * 1.5),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(defaultPadding,
                    defaultPadding * 2, defaultPadding, defaultPadding),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultBorderRadius * 3),
                    topRight: Radius.circular(defaultBorderRadius * 3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        LikeButton(
                          size: 22,
                          circleColor: CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                        ),
                        // Text(
                        //   "Rp" + widget.product.price.toString(),
                        //   style: Theme.of(context).textTheme.headline6,
                        // ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    // const Padding(
                    // padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    // child:
                    Text(
                      widget.product.description.toString(),
                      maxLines: 3,
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                    // ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      "Rp" + widget.product.price.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),

                    // Text(
                    //   "Colors",
                    //   style: Theme.of(context).textTheme.subtitle2,
                    // ),
                    // const SizedBox(height: defaultPadding / 2),
                    // Row(
                    //   children: const [
                    //     ColorDot(
                    //       color: Color(0xFFBEE8EA),
                    //       isActive: false,
                    //     ),
                    //     ColorDot(
                    //       color: Color(0xFF141B4A),
                    //       isActive: true,
                    //     ),
                    //     ColorDot(
                    //       color: Color(0xFFF4E5C3),
                    //       isActive: false,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: defaultPadding * 2),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            // setState(() {
                            //   // _counter++;
                            // });
                            addtocartProvider.addCart(
                              customerId: customerId,
                              productId: widget.product.id.toString(),
                              cartPrice: widget.product.price.toString(),
                              cartWeight: widget.product.weight.toString(),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shape: const StadiumBorder()),
                          child: const Text("Add to Cart"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
