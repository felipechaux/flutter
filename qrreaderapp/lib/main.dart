import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';
import 'package:qrreaderapp/src/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //modificar color barra posterior
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRREader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'map': (BuildContext context) => MapPage()
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}
