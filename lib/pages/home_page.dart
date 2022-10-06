import 'package:first_app/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:first_app/store/imageStore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _textController = TextEditingController();
  String texts = '';
  int loadedPages = 1;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5.0);

  final Counter counter = Counter();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (texts.isNotEmpty)
        counter.getImagesData(texts, true);
      else {
        counter.resetImgData();
      }
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
                  if (texts.isNotEmpty)
                    counter.getImagesData(texts, false);
                  else {
                    counter.resetImgData();
                  }
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.searchImg,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<String>(
            future: ApiService().fetchAlbum('car', false, loadedPages),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else if (snapshot.hasData) {
                return Flexible(child: Observer(builder: (context) {
                  return GridView.count(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      children:
                          List.generate(counter.dataResponse.length, (index) {
                        var Url =
                            'https://live.staticflickr.com/${counter.dataResponse[index]['server']}/${counter.dataResponse[index]['id']}_${counter.dataResponse[index]['secret']}_m.jpg';
                        return Padding(
                            padding: EdgeInsetsDirectional.all(4),
                            child: Image.network(Url));
                      }));
                }));
              } else {
                return Text(' ');
              }
            },
          ),
          Observer(builder: (_) {
            return counter.loader && texts.isNotEmpty
                ? CircularProgressIndicator()
                : SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
