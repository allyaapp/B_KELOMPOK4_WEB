import 'package:blackshop/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/ProductModels.dart';

class AllProductCard extends StatelessWidget {
  final ProductModels product;
  AllProductCard(this.product);
  // const AllProductCard({
  //   // Key? key,
  //   // required this.image,
  //   // required this.title,
  //   // required this.price,
  //   // required this.press,
  //   // required this.bgColor, required String subtitleProduct,
  // }) : super(key: key);
  // final String image, title;
  // final VoidCallback press;
  // final int price;
  // final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product),
            ),
          )),
      child: Container(
        // height: 250,
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Column(
          children: [
            Container(
              // height: 193,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: bgColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultBorderRadius)),
              ),
              child: Image.network(
                "https://cdd9-180-253-162-136.ap.ngrok.io/storage/products/" +
                    product.image.toString(),
                // height: 132,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.name.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: defaultPadding / 4),
                Text(
                  "Rp" + product.price.toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
