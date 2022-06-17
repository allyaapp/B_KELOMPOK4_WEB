import 'package:blackshop/models/CategoryModels.dart';
import 'package:blackshop/models/DetailCategoryModels.dart';
import 'package:blackshop/services/category_services.dart';
import 'package:blackshop/services/detailcategory_services.dart';
import 'package:flutter/cupertino.dart';

class DetailCategoryProvider with ChangeNotifier {
  List<DetailCategoryModels> _category = [];
  List<DetailCategoryModels> get category => _category;

  set category(List<DetailCategoryModels> category) {
    _category = category;
    notifyListeners();
  }

  Future<void> getListCategory({String? slug}) async {
    try {
      List<DetailCategoryModels> category =
          await DetailCategoryServices().getListCategory(slug: slug);
      _category = category;
      print(category);
    } catch (e) {
      print(e);
    }
  }
}
