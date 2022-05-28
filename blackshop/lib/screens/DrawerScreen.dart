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
          accountName: Text("Felisa Kamiliya"),
          currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMXf2JNZ7lulzXMf6PXXzOiVyi5q58zOPKEg&usqp=CAU")),
          accountEmail: Text("felisakamiliya@gmail.com"),
        ),
        DrawerListTile(
          iconData: Icons.account_circle,
          title: "Profile",
          onTilePressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        DrawerListTile(
          iconData: Icons.history,
          title: "History",
          onTilePressed: () {},
        ),
        DrawerListTile(
          iconData: Icons.logout,
          title: "Logout",
          onTilePressed: () {},
        ),
        // DrawerListTile(
        //   iconData: Icons.contacts,
        //   title: "contacts",
        //   onTilePressed: () {},
        // ),
        // DrawerListTile(
        //   iconData: Icons.bookmark_border,
        //   title: "Saved Message",
        //   onTilePressed: () {},
        // ),
        // DrawerListTile(
        //   iconData: Icons.phone,
        //   title: "Calls",
        //   onTilePressed: () {},
        // )
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
