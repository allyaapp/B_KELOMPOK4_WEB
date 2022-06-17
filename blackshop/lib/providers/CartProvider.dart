import 'package:blackshop/models/CartModels.dart';
import 'package:blackshop/models/CartProductModels.dart';
import 'package:blackshop/services/cart_services.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<CartModels> _carts = [];
  List<CartModels> get carts => _carts;

  set carts(List<CartModels> carts) {
    _carts = carts;
    notifyListeners();
  }

  Future<void> getCart({String? id}) async {
    try {
      List<CartModels> carts = await CartService().getCart(id: id);
      _carts = carts;
    } catch (e) {
      // print(e);
    }
  }
}
