import 'dart:convert';

import 'package:first_app/api/api.service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<String, dynamic> mapResponse;
  late List<dynamic> dataResponse;
  TextEditingController _textController = TextEditingController();
  String texts = '';

  @override
  void initState() {
    super.initState();
    getApi('');
  }

  getApi(text) {
     ApiService().fetchAlbum(text).then((value) => {
       setState(() {
         mapResponse = jsonDecode(value) ;
         dataResponse = mapResponse['photos']['photo'];
       })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flickr'),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: TextField(
                  controller: _textController,
                  onChanged: (text){
                    setState(() {
                      texts = text;
                      getApi(texts);
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search Image',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<String>(
                future: ApiService().fetchAlbum('car'), // async work
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return Text('Loading....');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if(snapshot.hasData){
                        return Flexible(child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(dataResponse.length, (index) {
                              var Url = 'https://live.staticflickr.com/${dataResponse[index]['server']}/${dataResponse[index]['id']}_${dataResponse[index]['secret']}_m.jpg';
                              return Padding(padding: EdgeInsetsDirectional.all(4),
                              child: Image.network(Url));
                            }
                            )
                        )  );
                      }else{
                        return Text('Expection error');
                      }
                  }
                },
              ),
            ],
          ),
        );
  }
}
