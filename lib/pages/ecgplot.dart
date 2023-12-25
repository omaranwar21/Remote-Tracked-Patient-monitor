import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:patient_monitor/widgets/customBar.dart';
import 'package:patient_monitor/widgets/customDrawer.dart';

class CsvPlotPage extends StatefulWidget {
  const CsvPlotPage({Key? key}) : super(key: key);

  @override
  State<CsvPlotPage> createState() => _CsvPlotPageState();
}

class _CsvPlotPageState extends State<CsvPlotPage>
    with SingleTickerProviderStateMixin {
  List<double> data = []; // List to store the ECG data
  int dataIndex = 0; // Index of the current data point
  late AnimationController controller;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("Arythmia");
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController arrhythmiaController =
      TextEditingController(); // Controller for the arrhythmia prediction text box

  @override
  void initState() {
    super.initState();
    loadData();
    // deviceToken();
    controller = AnimationController(
      duration: const Duration(
          milliseconds: 10000), // Total duration for the animation
      vsync: this,
    );
    controller.repeat(); // Loop the animation

    // Listen to the animation value and update the dataIndex accordingly
    controller.addListener(() {
      final animationValue = controller.value;
      final newDataIndex = (animationValue * (data.length - 1)).toInt();
      setState(() {
        dataIndex = newDataIndex;
      });
    });
  }

  // void deviceToken 

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Load the data from the ecg.csv file
  Future<void> loadData() async {
    Reference ref = _storage.ref().child('ecg_file.csv');

    File file = File("assets/ecg_sh.csv");
    ref.writeToFile(file);

    String fileData = await rootBundle.loadString('assets/ecg_sh.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(fileData);
    List<double> parsedData = [];

    for (List<dynamic> row in csvTable) {
      try {
        double value = double.parse(row[0].toString());
        parsedData.add(value);
      } catch (e) {
        print('Error parsing line: $row');
      }
    }

    data = parsedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Real-time ECG Chart',
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20), // Empty container above the ECG plot
            Expanded(
              child: data.isNotEmpty
                  ? LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: data.length.toDouble() - 1,
                        minY:
                            -1.5, // Adjust the minY and maxY values according to your data range
                        maxY: 1.5,
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(dataIndex + 1, (index) {
                              return FlSpot(index.toDouble(), data[index]);
                            }),
                            isCurved: true,
                            colors: [Colors.blue],
                            barWidth: 2,
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            SizedBox(
                height: 30), // Add space between the plot and the TextField
            StreamBuilder(
              stream:
                  dbRef.onValue, // Use onValue to listen for real-time updates
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Assuming the data under "Arythmia" is a string
                  String prediction =
                      snapshot.data?.snapshot.value?.toString() ?? '';
                  arrhythmiaController.text = prediction;
                }
                return TextField(
                  controller: arrhythmiaController,
                  decoration: InputDecoration(
                    labelText: 'Arrhythmia Prediction',
                    border: OutlineInputBorder(),
                    enabled: false, // Make the TextField read-only
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
