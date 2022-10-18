import 'package:flickr_image/screens/Profile/profileScreen.dart';
import 'package:flickr_image/screens/Settings/settingsScreen.dart';
import 'package:flutter/material.dart';

//ROUTES NAMES
const String ProfilePage = 'profile';
const String SettingsPage = 'settings';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProfilePage:
        return MaterialPageRoute(builder: (context) => const Profile());
      case SettingsPage:
        return MaterialPageRoute(builder: (context) => const Settings());
      default:
        throw ('This route name does not exist');
    }
  }
}
