import 'package:blackshop/models/OrderModels.dart';
import 'package:blackshop/providers/OrderProvider.dart';
import 'package:blackshop/screens/DetailOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:majestic/pages/detail_order_page.dart';

class CardOrder extends StatefulWidget {
  final OrderModels listOrders;
  // CardOrder(this.listOrders, {required OrderModels listOrders});
  // final OrderModels listOrders;
  const CardOrder({Key? key, required this.listOrders}) : super(key: key);

  @override
  State<CardOrder> createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  @override
  void initState() {
    // setState(() {});

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(order.data!.invoice.toString());
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailOrderPage(order: widget.listOrders))),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black26,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.listOrders.invoice.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: (widget.listOrders.status == "0")
                          ? Colors.yellow
                          : (widget.listOrders.status == "1")
                              ? Colors.amber
                              : (widget.listOrders.status == "2")
                                  ? Colors.orange
                                  : (widget.listOrders.status == "3")
                                      ? Colors.orangeAccent
                                      : (widget.listOrders.status == "4")
                                          ? Colors.green
                                          : Colors.redAccent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      widget.listOrders.status == "0"
                          ? "Waiting For Payment"
                          : widget.listOrders.status == "1"
                              ? "Confirmed"
                              : widget.listOrders.status == "2"
                                  ? "On Process"
                                  : widget.listOrders.status == "3"
                                      ? "Shipping"
                                      : widget.listOrders.status == "4"
                                          ? "Done"
                                          : "Cancel",
                      style: TextStyle(
                        color: widget.listOrders.status == "0"
                            ? Colors.black
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.listOrders.customerName.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.listOrders.cost.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.calendar_month_sharp,
                    size: 16,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.listOrders.createdAt.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
