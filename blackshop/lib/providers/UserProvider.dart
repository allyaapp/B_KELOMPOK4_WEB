import 'package:blackshop/models/AuthModels.dart';
import 'package:blackshop/services/auth_services.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  AuthModels? _user;

  AuthModels? get user => _user;

  void setUser(AuthModels user) {
    _user = user;
    notifyListeners();
  }

  // List<ProductModels> _products = [];
  // List<ProductModels> get products => _products;

  // set products(List<ProductModels> products) {
  //   _products = products;
  //   notifyListeners();
  // }

  Future<bool?> login(String email, String password) async {
    try {
      AuthModels data = await AuthService().masuk(email, password);
      _user = data;
      return true;
    } catch (e) {
      return false;
    }
    // try {
    //   List<ProductModels> products = await ProductService().getProducts();
    //   _products = products;
    // } catch (e) {
    //   print(e);
    // }
  }
}
