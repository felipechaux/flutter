import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inproext_app/src/bloc/provider.dart';
import 'package:inproext_app/src/pages/home_page.dart';
import 'package:inproext_app/src/pages/login_page.dart';
import 'package:inproext_app/src/pages/new_detail.dart';
import 'package:inproext_app/src/pages/news_page.dart';
import 'package:inproext_app/src/preferences/user_preferences.dart';
import 'package:inproext_app/src/providers/push_notification_provider.dart';
import 'package:inproext_app/src/utils/constants.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await Firebase.initializeApp();
  await prefs.initPrefs();

  runApp(Provider(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'news': (BuildContext context) => NewsPage(),
        'detail': (BuildContext context) => NewDetail(),
      },
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();

    pushProvider.messagesStream.listen((data) {
      print('argument from main');
      // Navigator.pushNamed(context, 'message');
      //  navigatorKey.currentState.pushNamed('message', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 7,
        navigateAfterSeconds: LoginPage(),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        imageBackground: AssetImage('assets/images/splash.png'),
        onClick: () => print("Flutter Egypt"),
        loaderColor: Constants.colorBlueInproext);
  }
}
