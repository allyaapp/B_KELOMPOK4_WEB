import 'package:blackshop/providers/OrderProvider.dart';
import 'package:blackshop/screens/home/components/orderCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 22.0,
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: Text(
          "Order List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            fontFamily: 'sans-serif-light',
            color: Color.fromRGBO(1, 38, 0, 1),
          ),
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black45,
              tabs: [
                Tab(text: 'Not yet paid'),
                Tab(text: 'Already paid'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: orderProvider.listOrders.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == orderProvider.listOrders.length - 1) {
                      return Column(
                        children: [
                          CardOrder(
                            listOrders: orderProvider.listOrders[i],
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      );
                    }
                    return CardOrder(
                      listOrders: orderProvider.listOrders[i],
                    );
                  },
                ),
                ListView.builder(
                  itemCount: orderProvider.listOrdersDone.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == orderProvider.listOrdersDone.length - 1) {
                      return Column(
                        children: [
                          CardOrder(
                            listOrders: orderProvider.listOrdersDone[i],
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      );
                    }
                    return CardOrder(
                      listOrders: orderProvider.listOrdersDone[i],
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
