import 'package:blackshop/models/AddtoCartModels.dart';
import 'package:blackshop/models/CheckOutModel.dart';
import 'package:blackshop/models/OrderModels.dart';
import 'package:blackshop/services/addtocart_services.dart';
import 'package:blackshop/services/order_services.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  CheckoutModel? _order;
  CheckoutModel? get order => _order;

  List<OrderModels> _listOrders = [];
  List<OrderModels> get listOrders => _listOrders;
  List<OrderModels> _listOrdersDone = [];
  List<OrderModels> get listOrdersDone => _listOrdersDone;

  set listOrders(List<OrderModels> listOrders) {
    _listOrders = listOrders;
    notifyListeners();
  }

  void setOrder(CheckoutModel order) {
    _order = order;
    notifyListeners();
  }

  set listOrdersDone(List<OrderModels> listOrdersDone) {
    _listOrdersDone = listOrdersDone;
    notifyListeners();
  }

  Future<void> getOrder({String? id}) async {
    try {
      List<OrderModels> listOrders = await OrderService().getOrder(id: id);
      _listOrders = listOrders;
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getOrderDone({String? id}) async {
    try {
      List<OrderModels> listOrdersDone =
          await OrderService().getOrderDone(id: id);
      _listOrdersDone = listOrdersDone;
    } catch (e) {
      // print(e);
    }
  }

  Future<bool> addOrder({
    String? customerId,
    String? subtotal,
    String? cost,
    String? shipping,
  }) async {
    try {
      CheckoutModel data = await OrderService().addOrder(
        customerId: customerId,
        subtotal: subtotal,
        cost: cost,
        shipping: shipping,
      );
      _order = data;
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> updateOrder({int? id}) async {
  //   try {
  //     OrderModels data = await OrderService().updateOrder(
  //       id: id,
  //     );
  //     _order = data;
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
