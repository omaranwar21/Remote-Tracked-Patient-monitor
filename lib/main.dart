import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:patient_monitor/pages/camera.dart';
import 'package:patient_monitor/pages/ecgplot.dart';
import 'package:patient_monitor/pages/homepage.dart';
import 'package:patient_monitor/pages/login.dart';
import 'package:patient_monitor/pages/plot.dart';
import 'package:patient_monitor/pages/register.dart';
import 'package:patient_monitor/pages/reset_password.dart';
import 'notification.dart';

// Notification received in the background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
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
        // initialRoute: 'register',
        initialRoute: 'ecg',
        routes: {
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'reset_password': (context) => const ResetPasswordPage(),
          'home': (context) => const HomePage(),
          'plot': (context) => const RealTimePlotting(
              chosneData: "Temperature",
              textTitle: "Real-Time Plotting",
              palet: [Color(0xff161A30), Color(0xff31304D), Color(0xffB6BBC4)]),
          'noti': (context) => const MyApp(),
          "camera": (context) => const CameraPage(),
          "ecg": (context) => const CsvPlotPage(),
          "plot2": (context) => const RealTimePlotting(
                chosneData: "Temperature",
                textTitle: "plot2",
                palet: [
                  Color(0xff392467),
                  Color(0xffA367B1),
                  Color(0xffFFD1E3)
                ],
              ),
        }),
  );
}
