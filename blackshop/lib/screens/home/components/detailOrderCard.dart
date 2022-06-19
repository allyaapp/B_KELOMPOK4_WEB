import 'dart:convert';
import 'dart:io';

import 'package:blackshop/models/OrderModels.dart';
import 'package:blackshop/providers/OrderProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardOrderDetail extends StatefulWidget {
  final OrderModels order;
  const CardOrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  State<CardOrderDetail> createState() => _CardOrderDetailState();
}

class _CardOrderDetailState extends State<CardOrderDetail> {
  List<PlatformFile>? image;
  int id = 0;
  String name = "";
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        id = sharedPreferences.getInt("id")!;
        name = sharedPreferences.getString("name")!;
      });
    }
  }

  void _imagepicker() async {
    image = (await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: false,
            allowedExtensions: null))
        ?.files;
    setState(() {});
    // print('Image Picker : ${image!.first.path}');
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    void _uploadImage() async {
      var uri = Uri.parse(
          'https://cdd9-180-253-162-136.ap.ngrok.io/api/checkout/payment/');
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var body = jsonEncode({
        'invoice': "xCCn-1655510312",
        'order_id': 23,
        'name': name,
        'transfer_to': "082228905435",
        'amount': 57000,
        // 'proof': request.send(),
      });
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath(
          'proof', image!.first.path.toString()));
      request.fields["invoice"] = widget.order.invoice.toString();
      request.fields["order_id"] = widget.order.id.toString();
      request.fields["name"] = name;
      request.fields["transfer_to"] = "082228905435";
      request.fields["amount"] = widget.order.cost.toString();
      var response = await request
          .send()
          .then((result) => http.Response.fromStream(result).then((response) {
                if (response.statusCode == 202) {
                  print(response.body);
                } else {
                  print("Error during connection to server");
                }
              }));
    }

    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text("Payment Is Being Checked"),
      backgroundColor: Colors.green,
    );
    return Card(
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
                      widget.order.invoice.toString(),
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
                    color: (widget.order.status == "0")
                        ? Colors.yellow
                        : (widget.order.status == "1")
                            ? Colors.amber
                            : (widget.order.status == "2")
                                ? Colors.orange
                                : (widget.order.status == "3")
                                    ? Colors.orangeAccent
                                    : (widget.order.status == "4")
                                        ? Colors.green
                                        : Colors.redAccent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    widget.order.status == "0"
                        ? "Waiting For Payment"
                        : widget.order.status == "1"
                            ? "Confirmed"
                            : widget.order.status == "2"
                                ? "On Process"
                                : widget.order.status == "3"
                                    ? "Shipping"
                                    : widget.order.status == "4"
                                        ? "Done"
                                        : "Cancel",
                    style: TextStyle(
                      color: widget.order.status == "0"
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
                      widget.order.customerName.toString(),
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
                      widget.order.cost.toString(),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transfer To",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Dana",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Account Number",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "082228905435",
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
            (widget.order.status == "0"
                ? Column(
                    children: [
                      image != null
                          ? Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 400,
                                  child: Image.file(
                                    File(image!.first.path.toString()),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Divider(
                                    color: Colors.black12,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () async {
                                      _uploadImage();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      // setState(() {});
                                      await Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .getOrder(
                                              id: widget.order.customerId);
                                      await Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .getOrderDone(
                                              id: widget.order.customerId);
                                      Navigator.pushNamed(context, '/history');
                                    },
                                    child: const Text(
                                      'Send Proof of Payment',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  _imagepicker();
                                },
                                child: const Text(
                                  'Select Proof of Payment',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                    ],
                  )
                : Container()
            // (widget.order.transfer == null
            //     ? Container()
            //     : Column(
            //         children: [
            //           Text(
            //             "Bukti Transfer",
            //           ),
            //           SizedBox(
            //             height: 8,
            //           ),
            //           Container(
            //             width: double.infinity,
            //             height: 400,
            //             decoration: BoxDecoration(
            //               image: DecorationImage(
            //                 fit: BoxFit.cover,
            //                 image: NetworkImage(
            //                   widget.order.transfer! == ""
            //                       ? 'https://m.nsoproject.com/webfile/no_image.png'
            //                       : Config.url +
            //                           '/' +
            //                           widget.order.transfer!.toString(),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           const Padding(
            //             padding: EdgeInsets.symmetric(vertical: 5),
            //             child: Divider(
            //               color: Colors.black12,
            //             ),
            //           )
            //         ],
            //       ))
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
                  widget.order.createdAt.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
