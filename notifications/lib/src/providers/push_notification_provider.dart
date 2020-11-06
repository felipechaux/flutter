import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //subscripcion notificaciones
  final _messagesStreamController = StreamController<String>.broadcast();

  //flujo para suscripcion
  Stream<String> get messagesStream => _messagesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }

  initNotifications() async {
    //permiso para notificacion
    await _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((value) => {
          _firebaseMessaging.subscribeToTopic("Football").then((onValue) {
            print("Topic Subscribed Successfully");
          }).catchError((onError) {
            print("error subscribing to topic ${onError.toString()}");
          })
        });

    print('-----FCM token -------');

    // print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('-----onMEssage--------------');
    // print('message : $message');
    // print('arguments: $arguments');
    final arguments = message['data']['comida'] ?? 'no-data';

    _messagesStreamController.sink.add(arguments);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('-----onLaunch--------------');
    //print('message : $message');
    //print('arguments: $arguments');
    final arguments = message['data']['comida'] ?? 'no-data';
    _messagesStreamController.sink.add(arguments);
  }

  //clic en notificacion
  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('-----onResume--------------');
    // print('message : $message');
    // print('arguments: $arguments');
    final arguments = message['data']['comida'];
    _messagesStreamController.sink.add(arguments);
  }

  dispose() {
    _messagesStreamController?.close();
  }
}
