import 'package:blackshop/models/RegisterModels.dart';
import 'package:blackshop/services/register_services.dart';
import 'package:flutter/cupertino.dart';

class RegisterProvider with ChangeNotifier {
  RegisterModels? _user;

  RegisterModels? get user => _user;

  void setUser(RegisterModels user) {
    _user = user;
    notifyListeners();
  }

  // List<ProductModels> _products = [];
  // List<ProductModels> get products => _products;

  // set products(List<ProductModels> products) {
  //   _products = products;
  //   notifyListeners();
  // }

  Future<bool> register({String? name, String? email, String? password}) async {
    try {
      RegisterModels data = await RegisterService()
          .register(name: name, email: email, password: password);
      _user = data;
      print(data);
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
