import 'dart:convert';

import 'package:first_app/api/api.service.dart';
import 'package:first_app/main.dart';
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
  int loadedPages = 1;
  bool loader = false;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    dataResponse = [];
  }

  getApi(text, loadMore, loadedPages) {
    if (texts.isNotEmpty) {
      setState(() {
        loader = !loader;
      });
      ApiService().fetchAlbum(text, loadMore, loadedPages).then((value) => {
            setState(() {
              mapResponse = jsonDecode(value);
              if (loadMore) {
                dataResponse = dataResponse + mapResponse['photos']['photo'];
                loadedPages++;
              } else {
                dataResponse = mapResponse['photos']['photo'];
              }
              loader = !loader;
            })
          });
    } else {
      dataResponse = [];
    }
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      getApi(texts, true, loadedPages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {
                  texts = text;
                  getApi(texts, false, loadedPages);
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
            future: ApiService()
                .fetchAlbum('car', false, loadedPages), // async work
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else if (snapshot.hasData) {
                return Flexible(
                    child: GridView.count(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        children: List.generate(dataResponse.length, (index) {
                          var Url =
                              'https://live.staticflickr.com/${dataResponse[index]['server']}/${dataResponse[index]['id']}_${dataResponse[index]['secret']}_m.jpg';
                          return Padding(
                              padding: EdgeInsetsDirectional.all(4),
                              child: Image.network(Url));
                        })));
              } else {
                return Text(' ');
              }
            },
          ),
          if (loader && texts.isNotEmpty)
            CircularProgressIndicator(
              strokeWidth: 3.0,
            )
        ],
      ),
    );
  }
}
