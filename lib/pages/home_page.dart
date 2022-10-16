import 'package:first_app/api/api.service.dart';
import 'package:first_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:first_app/store/imageStore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textController = TextEditingController();
  String texts = '';
  int loadedPages = 1;
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5.0);

  final Counter counter = Counter();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // printData();
  }

  // printData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? action = prefs.getString('imageData');
  //   print(action);
  // }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (texts.isNotEmpty) {
        counter.getImagesData(texts, true);
      } else {
        counter.resetImgData();
      }
    }
  }

  imageUrl(base, index) {
    return 'https://live.staticflickr.com/${base[index]['server']}/${base[index]['id']}_${base[index]['secret']}_m.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {
                  texts = text;
                  if (texts.isNotEmpty) {
                    counter.getImagesData(texts, false);
                  } else {
                    counter.resetImgData();
                  }
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.searchImg,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<String>(
            future: ApiService().fetchAlbum(texts, false, loadedPages),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Flexible(child: Observer(builder: (context) {
                  return GridView.count(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      children:
                          List.generate(counter.dataResponse.length, (index) {
                        var Url = imageUrl(counter.dataResponse, index);
                        return Padding(
                            padding: const EdgeInsetsDirectional.all(4),
                            child: Image.network(Url));
                      }));
                }));
              } else {
                return const Text(' ');
              }
            },
          ),
          Observer(builder: (_) {
            return counter.loader && texts.isNotEmpty
                ? const CircularProgressIndicator()
                : const SizedBox.shrink();
          }),
          Center(
            child: BlocConsumer<InternetBloc, InternetState>(
              listener: (context, state) {
                if (state is InternetGainedState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Internet connected'),
                    backgroundColor: Colors.green,
                  ));
                } else if (state is InternetLossState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Internet not connected!')));
                }
              },
              builder: (context, state) {
                if (state is InternetGainedState) {
                  return Text('Internet connected');
                } else if (state is InternetLossState) {
                  return Text('Internet not connnected');
                } else {
                  return Text('Loading...');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
