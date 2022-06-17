import 'package:blackshop/models/AddtoCartModels.dart';
import 'package:blackshop/services/addtocart_services.dart';
import 'package:flutter/cupertino.dart';

class AddtoCartProvider with ChangeNotifier {
  AddtoCartModels? _carts;
  AddtoCartModels? get carts => _carts;

  void setCarts(AddtoCartModels carts) {
    _carts = carts;
    notifyListeners();
  }

  Future<bool> addCart({
    String? customerId,
    String? productId,
    String? cartPrice,
    String? cartWeight,
    // String? qty,
    // String? updatedAt,
    // String? createdAt,
    // int? id,
  }) async {
    try {
      AddtoCartModels data = await AddtoCartService().addCart(
        customerId: customerId,
        productId: productId,
        cartPrice: cartPrice,
        cartWeight: cartWeight,
        // qty: qty,
        // updatedAt: updatedAt,
        // createdAt: createdAt,
        // id: id,
      );
      _carts = data;
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<void> addCart({String? id}) async {
  //   try {
  //     List<AddtoCartModels> carts = await AddtoCartService().addCart(id: id);
  //     _carts = carts;
  //   } catch (e) {
  //     // print(e);
  //   }
  // }
}
