import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChartScreen extends StatefulWidget {
  static const routeName = '/chart-screen';

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  User _user = FirebaseAuth.instance.currentUser;
  final _controller = TextEditingController();

  List<FlSpot> data = [];

  void _recordWeight(weight) async {
    FirebaseFirestore.instance
        .collection('bodyweight')
        .doc(_user.uid)
        .collection('weights')
        .add({
      "weight": weight,
      "createdAt": Timestamp.now(),
    });
    _controller.clear();
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'APR';
              case 8:
                return 'MAY';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 140:
                return '140';
              case 150:
                return '150';
              case 160:
                return '160';
              case 170:
                return '170';
              case 180:
                return '180';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 140,
      maxY: 180,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    data = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("Chartz"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFAB55FF),
                Color(0xFF375FEA),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.70,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Color(0xff232d37)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 12.0, top: 24, bottom: 12),
                        child: LineChart(mainData()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bodyweight')
                  .doc(_user.uid)
                  .collection('weights')
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final recordedWeights = snapshot.data.docs;
                return Container(
                  height: 200,
                  child: ListView.builder(
                      reverse: true,
                      itemCount: recordedWeights.length,
                      itemBuilder: (context, index) {
                        print(
                            "index: $index. Weight: ${recordedWeights[index]['weight']}");
                        data.add(
                          FlSpot(
                            (index.toDouble() * 2),
                            double.parse(recordedWeights[index]['weight']),
                          ),
                        );
                        return Text(
                          recordedWeights[index]['weight'],
                        );
                      }),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _controller,
                )),
                ElevatedButton.icon(
                  onPressed: () {
                    _recordWeight(_controller.text.trim());
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Record Weight",
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 400,
              child: Text(
                "Jeez caroline stop judging me on this shit UI right now. Im just testing 🙄",
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
