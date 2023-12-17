import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'login.dart';
import 'register.dart';
import 'reset_password.dart';
import 'homepage.dart';
import 'plot.dart';
import 'notification.dart';


// Notification received in the background
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp();
}


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyBedb_YI8cEEahX0ymhF5ojcmhIGMwAP5k', // Your apiKey
    appId: '1:771972734729:android:1ad79451bffcf413747dd8', // Your appId
    messagingSenderId: '771972734729', // Your messagingSenderId
    projectId: 'smarticu-c78aa', // Your projectId
    databaseURL: 'https://smarticu-c78aa-default-rtdb.firebaseio.com/',
    ),
  );
  // for background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'register',
        routes: {
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'reset_password': (context) => const ResetPasswordPage(),
          'home': (context) => const HomePage(),
          'plot': (context) => const RealTimePlotting(),
          'noti':(context) =>  const MyApp(),
        }),
  );
}