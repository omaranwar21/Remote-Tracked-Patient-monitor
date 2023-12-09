import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'register.dart';
import 'reset_password.dart';
import 'homepage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
    apiKey: 'AIzaSyBedb_YI8cEEahX0ymhF5ojcmhIGMwAP5k', // Your apiKey
    appId: '1:771972734729:android:1ad79451bffcf413747dd8', // Your appId
    messagingSenderId: '771972734729', // Your messagingSenderId
    projectId: 'smarticu-c78aa', // Your projectId
    ),
  );
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'reset_password': (context) => const ResetPasswordPage(),
          'home': (context) => const HomePage(),
        }),
  );
}
