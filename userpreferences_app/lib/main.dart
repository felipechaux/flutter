import 'package:flutter/material.dart';
import 'package:userpreferences_app/src/pages/home_page.dart';
import 'package:userpreferences_app/src/pages/settings_page.dart';
import 'package:userpreferences_app/src/share_pref/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //en toda la app se tendran las preferencias listas
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User preferences',
      initialRoute: prefs.lastPage,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        SettingsPage.routeName: (BuildContext context) => SettingsPage(),
      },
    );
  }
}
