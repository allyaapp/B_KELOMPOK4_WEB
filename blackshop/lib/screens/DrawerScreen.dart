import 'dart:convert';

import 'package:blackshop/providers/OrderProvider.dart';
import 'package:blackshop/screens/HistoryPage.dart';
import 'package:blackshop/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blackshop/LoginScreen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late SharedPreferences sharedPreferences;
  String name = "";
  String profile = "";
  String email = "";
  int id = 0;

  @override
  void initState() {
    getData();
    checkLoginStatus();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        id = sharedPreferences.getInt("id")!;
        name = sharedPreferences.getString("name")!;
        profile = sharedPreferences.getString("profile")!;
        email = sharedPreferences.getString("email")!;
      });
    }
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  // late SharedPreferences sharedPreferences;
  // SharedPreferences sharedPreferences = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: new NetworkImage(profile),
                  // (profile != null)
                  //     ? NetworkImage(profile)
                  //     : NetworkImage(
                  //         "https://www.woolha.com/media/2020/03/flutter-circleavatar-radius.jpg",
                  // ),
                  fit: BoxFit.contain)),
          // child: Image.network(
          //   profile,
          //   // width: 80,
          //   // height: 80,
          //   fit: BoxFit.cover,
          // ),
        ),
        Center(
          child: Text(
            name,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto-Bold',
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),
        Center(
          child: Text(
            email,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto-Bold',
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),

        Divider(
          thickness: 0.5,
          height: 10,
          color: Colors.black.withOpacity(0.5),
        ),
        // const UserAccountsDrawerHeader(
        //   currentAccountPicture: ClipOval(
        //     child: Image(
        //       image: NetworkImage(
        //           // sharedPreferences.getString("profile")
        //           "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/2016_RiP_Bring_Me_the_Horizon_-_Oliver_Sykes_-_by_2eight_-_8SC6698.jpg/1200px-2016_RiP_Bring_Me_the_Horizon_-_Oliver_Sykes_-_by_2eight_-_8SC6698.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   accountName: Text('${name}'),
        //   accountEmail: Text("antonsebrianto@gmail.com"),
        // ),
        DrawerListTile(
          iconData: Icons.account_circle,
          title: "Profile",
          onTilePressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        DrawerListTile(
          iconData: Icons.favorite,
          title: "Wishlist",
          onTilePressed: () {},
        ),
        DrawerListTile(
          iconData: Icons.history,
          title: "History",
          onTilePressed: () async {
            await Provider.of<OrderProvider>(context, listen: false)
                .getOrder(id: id.toString());
            await Provider.of<OrderProvider>(context, listen: false)
                .getOrderDone(id: id.toString());
            Navigator.pushNamed((context), '/history');
          },
        ),
        DrawerListTile(
          iconData: Icons.logout,
          title: "Logout",
          onTilePressed: () async {
            Dialog errorDialog = Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)), //this right here
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 100.0,
                width: 350.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Are you sure want to logout?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                                child: RaisedButton(
                              child: const Text("Logout"),
                              textColor: Colors.white,
                              color: Colors.red,
                              onPressed: () {
                                sharedPreferences.clear();
                                sharedPreferences.commit();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            )),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                                child: RaisedButton(
                              child: const Text("Cancel"),
                              textColor: Colors.white,
                              color: Colors.green,
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            )),
                          ),
                          flex: 2,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
            showDialog(
                context: context,
                builder: (BuildContext context) => errorDialog);
          },
        ),
      ],
    ));
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final VoidCallback? onTilePressed;
  const DrawerListTile(
      {Key? key, this.iconData, this.title, this.onTilePressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title!,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
