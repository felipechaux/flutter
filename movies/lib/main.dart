import 'package:flutter/material.dart';
import 'package:movies/src/pages/detail_movie.dart';
import 'package:movies/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          'detail': (BuildContext context) => DetailMovie(),
        });
  }
}
