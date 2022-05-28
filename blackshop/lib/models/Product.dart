import 'package:flutter/material.dart';

class Product {
  final String image, title;
  final int price;
  final Color bgColor;

  Product({
    required this.image,
    required this.title,
    required this.price,
    this.bgColor = const Color(0xFFEFEFF2),
  });
}

List<Product> demo_product = [
  Product(
    image: "assets/images/kripca.png",
    title: "Keripik Kaca",
    price: 6000,
    bgColor: const Color(0xFFFEFBF9),
  ),
  Product(
    image: "assets/images/ms_glow.png",
    title: "Paket Acne Ms Glow",
    price: 500000,
    bgColor: const Color(0xFFF8FEFB),
  ),
  Product(
    image: "assets/images/hoodie_hijau.png",
    title: "Hoodie Hijau (Allsize)",
    price: 500000,
    bgColor: const Color(0xFFF8FEFB),
  ),
  Product(
    image: "assets/images/product_3.png",
    title: "Casual Nolin",
    price: 149,
    bgColor: const Color(0xFFEEEEED),
  ),
];
