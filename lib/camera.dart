// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;

// Future<void> connectCamera() async {
//   int port = 55000;
//   print("HI");
//   await RawDatagramSocket.bind('192.168.43.219', port).then(
//     (RawDatagramSocket socket) => socket.forEach(
//       (event) {
//         print("In Socket Event");
//         if (event == RawSocketEvent.read) {
//           print("Listening");
//           Datagram? datagram = socket.receive();
//           datagram!.data.forEach((element) => print(element));
//         }
//       },
//     ),
//   );
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final String udpIP = "172.20.10.5"; // Replace with your ESP32Cam IP
//   final int udpPort = 55000; // Match the port used in the ESP32Cam code
//   RawDatagramSocket? udpSocket;
//   Uint8List imageBuffer = Uint8List(0);

//   @override
//   void initState() {
//     super.initState();
//     // initUDPSocket();
//     connectCamera();
//   }

//   void initUDPSocket() async {
//     try {
//       udpSocket =
//           await RawDatagramSocket.bind(InternetAddress.anyIPv4, udpPort);
//       udpSocket!.listen((RawSocketEvent event) {
//         if (event == RawSocketEvent.read) {
//           Datagram dg = udpSocket!.receive()!;
//           imageReceive(dg.data);
//         }
//       });
//     } catch (e) {
//       print("Error creating UDP socket: $e");
//     }
//   }

//   void imageReceive(Uint8List data) {
//     if (data[0] == 0xFF && data[1] == 0xD8) {
//       imageBuffer = Uint8List(0);
//     }
//     imageBuffer = Uint8List.fromList([...imageBuffer, ...data]);
//     if (data[data.length - 2] == 0xFF && data[data.length - 1] == 0xD9) {
//       viewImage(Uint8List.fromList(imageBuffer));
//     }
//   }

//   void viewImage(Uint8List imageData) {
//     img.Image? image = img.decodeImage(imageData);
//     if (image != null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Container(
//               child: Image.memory(Uint8List.fromList(imageData)),
//             ),
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Receiver'),
//       ),
//       body: const Center(
//         child: Text('Waiting for image data...'),
//       ),
//     );
//   }
// }
