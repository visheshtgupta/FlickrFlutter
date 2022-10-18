import 'package:flickr_image/api/api.config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> fetchAlbum(text, loadMore, loadedPages) async {
    var httpsUri = Uri(
        scheme: 'https',
        host: 'api.flickr.com',
        path: '/services/rest',
        queryParameters: {
          'method': 'flickr.photos.search',
          'api_key': FLICKR_API_KEY,
          'format': 'json',
          'license': '4',
          'nojsoncallback': '1',
          'text': text,
          'sort': 'interestingness-desc',
          'per_page': '10',
          'page': loadMore ? '$loadedPages' : '1',
        });

    var response = await http.get(httpsUri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
