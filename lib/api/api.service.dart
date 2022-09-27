import 'package:http/http.dart' as http;

class ApiService {
  Future<String> fetchAlbum(text) async {
    var httpsUri = Uri(
    scheme: 'https',
    host: 'api.flickr.com',
    path: '/services/rest',
    queryParameters: {'method':'flickr.photos.search','api_key':'23afa6d878afc63b94f925fe662bee71','format':'json','license':'4','nojsoncallback':'1','text': text, 'sort': 'interestingness-desc','per_page':'10','page':'1'});

    var response = await http.get(httpsUri);
    if (response.statusCode == 200) {
      return response.body;
    }else {
      throw Exception('Failed to load album');
    }
  }
}