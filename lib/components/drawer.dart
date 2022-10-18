import 'package:flutter/material.dart';
import 'package:flickr_image/routes/routes.dart' as route;

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Vishesht'),
              accountEmail: Text("gvishesht@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU'),
              )),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            subtitle: Text("Personal"),
            trailing: Icon(Icons.edit),
            onTap: () => Navigator.pushNamed(context, route.ProfilePage),
          ),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              trailing: const Icon(Icons.send),
              onTap: () => Navigator.pushNamed(context, route.SettingsPage)),
        ],
      ),
    );
  }
}
