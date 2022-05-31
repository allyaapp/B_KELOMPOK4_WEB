import 'package:blackshop/screens/profile.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        const UserAccountsDrawerHeader(
          currentAccountPicture: ClipOval(
      child: Image(
          image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/2016_RiP_Bring_Me_the_Horizon_-_Oliver_Sykes_-_by_2eight_-_8SC6698.jpg/1200px-2016_RiP_Bring_Me_the_Horizon_-_Oliver_Sykes_-_by_2eight_-_8SC6698.jpg"),
                  fit: BoxFit.cover,
                  ),),
          accountName: Text("Anton Sebrianto"),
          accountEmail: Text("antonsebrianto@gmail.com"),
        ),
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
          onTilePressed: () {},
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
                                Navigator.pushNamed(context, '/login');
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
