import 'package:flickr_image/api/api.service.dart';
import 'package:flickr_image/common/debouncer.dart';
import 'package:flickr_image/cubit/internet_cubit/internet_cubit.dart';
import 'package:flickr_image/store/imageStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../api/api.config.dart';

class SearchImage extends StatefulWidget {
  const SearchImage({Key? key}) : super(key: key);

  @override
  State<SearchImage> createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  final TextEditingController _textController = TextEditingController();
  String searchText = '';
  int loadedPages = 1;
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5.0);

  final Counter counter = Counter();

  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (searchText.isNotEmpty) {
        counter.getImagesData(searchText, true);
      } else {
        counter.resetImgData();
      }
    }
  }

  imageUrl(base, index) {
    return '$IMAGE_BASE_URL/${base[index]['server']}/${base[index]['id']}_${base[index]['secret']}_m.jpg';
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
                _debouncer.run(() => {
                      setState(() {
                        searchText = text;
                        if (searchText.isNotEmpty) {
                          counter.getImagesData(searchText, false);
                        } else {
                          counter.resetImgData();
                        }
                      })
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
            future: ApiService().fetchAlbum(searchText, false, loadedPages),
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
                            padding: const EdgeInsetsDirectional.all(6),
                            child: Image.network(
                              Url,
                              fit: BoxFit.cover,
                            ));
                      }));
                }));
              } else {
                return const Text(' ');
              }
            },
          ),
          Observer(builder: (_) {
            return counter.loader && searchText.isNotEmpty
                ? const CircularProgressIndicator()
                : const SizedBox.shrink();
          }),
          BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state == InternetState.Gained) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Internet connected'),
                  backgroundColor: Colors.green,
                ));
              } else if (state == InternetState.Lost) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Internet not connected!')));
              }
            },
          )
        ],
      ),
    );
  }
}
