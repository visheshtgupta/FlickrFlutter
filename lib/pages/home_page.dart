import 'package:flutter/material.dart';
import '../dummyimg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<DummyImg> quotes = [
    DummyImg(
        desc: "Lady with a red umbrella",
        img: "https://googleflutter.com/sample_image.jpg"),
    DummyImg(
        desc: "Some kind of bird",
        img:
            "http://books.google.com/books/content?id=gsK9jwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api"),
    DummyImg(
        desc: "The attack of dragons",
        img: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
    DummyImg(
        desc: "Beautiful scenery",
        img: "https://googleflutter.com/sample_image.jpg"),
    DummyImg(
        desc: "Lady with a red umbrella",
        img: "https://googleflutter.com/sample_image.jpg"),
    DummyImg(
        desc: "Some kind of bird",
        img:
            "http://books.google.com/books/content?id=gsK9jwEACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api"),
    DummyImg(
        desc: "The attack of dragons",
        img: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
    DummyImg(
        desc: "Beautiful scenery",
        img: "https://googleflutter.com/sample_image.jpg"),
    DummyImg(
        desc: "The attack of dragons",
        img: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
    DummyImg(
        desc: "Beautiful scenery",
        img: "https://googleflutter.com/sample_image.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flickr'),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                accountName: Text('Vishesht'),
                accountEmail: Text("gvishesht@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Free-Image.png"),
                ),
              ),
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
        body: Column(
            children: [
               const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search Image',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: quotes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: [
                        Image.network(
                          quotes[index].img,
                          width: 150,
                          height: 150,
                        ),
                        Text(quotes[index].desc)
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        );
  }
}
