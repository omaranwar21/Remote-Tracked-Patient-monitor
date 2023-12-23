import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:patient_monitor/widgets/customBar.dart';
import 'package:patient_monitor/widgets/customDrawer.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // RawDatagramSocket? udpSocket;
  // Uint8List imageBuffer = Uint8List(0);
  Image image = Image.memory(Uint8List(0));

  void connectCamera() async {
    int port = 55000;
    Uint8List imageBuffer =
        Uint8List(0); // Initialize an empty byte list to store received data

    await RawDatagramSocket.bind(InternetAddress.anyIPv4, port).then(
      (RawDatagramSocket socket) => socket.forEach(
        (event) {
          print(
              "In Socket Event ================================================");
          if (event == RawSocketEvent.read) {
            print("Listening ***************************************");
            Datagram? datagram = socket.receive();

            Uint8List data = datagram!.data;

            if (data[0] == 0xff && data[1] == 0xd8) {
              imageBuffer = Uint8List(0);
            }
            imageBuffer = Uint8List.fromList([...imageBuffer, ...data]);

            if (data[data.length - 1] == 0xd9 &&
                data[data.length - 2] == 0xff) {
              setState(() {
                image = Image.memory(Uint8List.fromList(imageBuffer),
                    gaplessPlayback: true);
              });
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    connectCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'LIVE Camera',
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: image,
      ),
    );
  }
}
