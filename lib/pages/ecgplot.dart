import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../widgets/ploting.dart'; // Import the Ploting widget

class CsvPlotPage extends StatefulWidget {
  const CsvPlotPage({Key? key}) : super(key: key);

  @override
  State<CsvPlotPage> createState() => _CsvPlotPageState();
}

class _CsvPlotPageState extends State<CsvPlotPage> {
  List<List<dynamic>> csvData = [];
  bool loading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadCSVData();
  }

  Future<void> _loadCSVData() async {
    try {
      String csvString = await rootBundle.loadString('../../assets/ecg.csv');
      List<List<dynamic>> parsedCsv =
          const CsvToListConverter().convert(csvString);
      setState(() {
        csvData = parsedCsv;
        loading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error loading CSV data: $error';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSV Plotting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (loading || errorMessage.isNotEmpty) ...[
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (loading) const CircularProgressIndicator(),
                    if (errorMessage.isNotEmpty)
                      Text(errorMessage,
                          style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ] else if (csvData.isNotEmpty) ...[
              Expanded(
                child: Ploting(
                  dataCount: csvData.length,
                  dataPoints: _getFlSpots(),
                  palet: [],
                  maximumY: 0.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getFlSpots() {
    if (csvData.isEmpty) return [];

    return csvData.asMap().entries.map((entry) {
      if (entry.value.isNotEmpty) {
        // print("//////////////");

        return FlSpot(entry.key.toDouble(), entry.value[0].toDouble());
      } else {
        // Handle the case where the entry doesn't have enough elements
        // print("****************");
        return FlSpot(entry.key.toDouble(), 0.0);
      }
    }).toList();
  }
}
