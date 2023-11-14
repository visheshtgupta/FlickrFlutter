import 'package:first_app/pages/profile.dart';
import 'package:first_app/pages/settings.dart';
import 'package:flutter/material.dart';

//ROUTES NAME
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
