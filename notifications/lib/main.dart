import 'package:flutter/material.dart';
import 'package:notifications/src/pages/home_page.dart';
import 'package:notifications/src/pages/message_page.dart';
import 'package:notifications/src/providers/push_notification_provider.dart';

void main() => runApp(MyApp());

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
      // print('argument from main : $argument');
      // Navigator.pushNamed(context, 'message');
      navigatorKey.currentState.pushNamed('message', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext c) => HomePage(),
          'message': (BuildContext c) => MessagePage()
        });
  }
}
