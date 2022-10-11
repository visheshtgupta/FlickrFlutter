import 'dart:convert';

import 'package:first_app/api/api.service.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'imageStore.g.dart';

class Counter = _Counter with _$Counter;

abstract class _Counter with Store {
  @observable
  List dataResponse = [];

  @observable
  int loadedPages = 1;

  @observable
  bool loader = false;

  Map mapResponse = {};

  void saveData(data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imageData', data.toString());
  }

  @action
  void getImagesData(text, loadMore) {
    loader = true;
    if (loadMore) {
      loadedPages++;
    } else {
      loadedPages = 1;
    }
    ApiService().fetchAlbum(text, loadMore, loadedPages).then((value) => {
          mapResponse = jsonDecode(value),
          if (loadMore)
            {
              dataResponse = dataResponse + mapResponse['photos']['photo'],
            }
          else
            {
              dataResponse = mapResponse['photos']['photo'],
            },
          loader = false,
          saveData(dataResponse)
        });
  }

  @action
  void resetImgData() {
    dataResponse = [];
    mapResponse = {};
  }
}
