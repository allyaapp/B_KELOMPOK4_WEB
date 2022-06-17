import 'package:blackshop/models/CategoryModels.dart';
import 'package:blackshop/services/category_services.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModels> _category = [];
  List<CategoryModels> get category => _category;

  set category(List<CategoryModels> category) {
    _category = category;
    notifyListeners();
  }

  Future<void> getCategory() async {
    try {
      List<CategoryModels> category = await CategoryService().getCategory();
      _category = category;
      // print("object");
    } catch (e) {
      // print(e);
    }
  }
}
