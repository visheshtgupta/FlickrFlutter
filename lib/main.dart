import 'package:flutter/material.dart';
import 'package:first_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDark = false;

ThemeData _lightTheme =
    ThemeData(primarySwatch: Colors.amber, brightness: Brightness.light);

ThemeData _darkTheme =
    ThemeData(primarySwatch: Colors.grey, brightness: Brightness.dark);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? _darkTheme : _lightTheme,
      title: 'Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flickr'),
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.nights_stay : Icons.wb_sunny,
              ),
              iconSize: 26,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
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
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text("gvishesht@gmail.com"),
                trailing: Icon(Icons.send),
              ),
            ],
          ),
        ),
        body: Home(),
      ),
    );
  }
}
