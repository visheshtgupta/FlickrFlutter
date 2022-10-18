import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  void saveData(data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imageData', data.toString());
  }
}
