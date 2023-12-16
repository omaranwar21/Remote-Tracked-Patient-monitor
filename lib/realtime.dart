import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTime extends StatefulWidget {
  final void Function(int temperature) onTemperatureUpdate;

  const RealTime({Key? key, required this.onTemperatureUpdate}) : super(key: key);

  @override
  State<RealTime> createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("RealData");
  int? temperature;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const CircularProgressIndicator();
        }

        final Map<dynamic, dynamic>? dataMap =
            snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

        if (dataMap == null) {
          return const Center(child: Text('Data is null'));
        }

        temperature = dataMap['Temperature'] as int?;

        // Schedule the setState to run after the build process is complete
        Future.delayed(Duration.zero, () {
          if (temperature != null) {
            widget.onTemperatureUpdate(temperature!);
          }
        });

        return Center(
          child: Container(),
        );
      },
    );
  }
}
