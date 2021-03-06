import 'package:flutter/material.dart';
import 'package:formvalidationapp/src/bloc/provider.dart';
import 'package:formvalidationapp/src/pages/home_page.dart';
import 'package:formvalidationapp/src/pages/login_page.dart';
import 'package:formvalidationapp/src/pages/product_page.dart';
import 'package:formvalidationapp/src/pages/register_page.dart';
import 'package:formvalidationapp/src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //en toda la app se tendran las preferencias listas
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    print(prefs.token);

    //uso de inheritedWidget
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'home': (BuildContext context) => HomePage(),
        'product': (BuildContext context) => ProductPage()
      },
      //cambiar color primario - funciona para textfields
      theme: ThemeData(primaryColor: Colors.deepPurple),
    ));
  }
}
