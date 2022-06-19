import 'package:blackshop/models/OrderModels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/components/detailOrderCard.dart';

class DetailOrderPage extends StatefulWidget {
  final OrderModels order;
  const DetailOrderPage({Key? key, required this.order}) : super(key: key);

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Detail Order"),
        // centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            width: double.maxFinite,
            child: CardOrderDetail(
              order: widget.order,
            ),
          ),
        ],
      ),
    );
  }
}
