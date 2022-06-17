import 'package:blackshop/models/ProductModels.dart';
import 'package:blackshop/services/product_services.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModels> _products = [];
  List<ProductModels> get products => _products;

  set products(List<ProductModels> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModels> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      // print(e);
    }
  }
}
