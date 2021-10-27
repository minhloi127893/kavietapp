import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../main.dart';

class BarChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = Colors.orangeAccent;
  final Color rightBarColor = Colors.lightBlueAccent;
  final double width = 2;

  List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 0, 0);
    final barGroup2 = makeGroupData(1, 0, 0);
    final barGroup3 = makeGroupData(2, 0, 0);
    final barGroup4 = makeGroupData(3, 0, 0);
    final barGroup5 = makeGroupData(4, 0, 0);
    final barGroup6 = makeGroupData(5, 0, 0);
    final barGroup7 = makeGroupData(6, 0, 0);
    final barGroup8 = makeGroupData(7, 0, 0);
    final barGroup9 = makeGroupData(8, 0, 0);
    final barGroup10 = makeGroupData(9, 0, 0);
    final barGroup11 = makeGroupData(10, 0, 0);
    final barGroup12 = makeGroupData(11, 0, 0);
    final barGroup13 = makeGroupData(12, 0, 0);
    final barGroup14 = makeGroupData(13, 0, 0);
    final barGroup15 = makeGroupData(14, 0, 0);
    final barGroup16 = makeGroupData(15, 0, 0);
    final barGroup17 = makeGroupData(16, 0, 0);
    final barGroup18 = makeGroupData(17, 0, 0);
    final barGroup19 = makeGroupData(18, 0, 0);
    final barGroup20 = makeGroupData(19, 0, 0);
    final barGroup21 = makeGroupData(20, 0, 0);
    final barGroup22 = makeGroupData(21, 0, 0);
    final barGroup23 = makeGroupData(22, 15.879000, 6.990000);
    final barGroup24 = makeGroupData(23, 0, 0);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
      barGroup13,
      barGroup14,
      barGroup15,
      barGroup16,
      barGroup17,
      barGroup18,
      barGroup19,
      barGroup20,
      barGroup21,
      barGroup22,
      barGroup23,
      barGroup24,
    ];

    showingBarGroups = items;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            top: Constants.kPadding,
            left: Constants.kPadding / 2,
            right: Constants.kPadding / 2,
            bottom: Constants.kPadding),
        child: AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        width: 38,
                      ),
                      const SizedBox(
                        width: 38,
                      ),
                      const Text(
                        'Doanh thu tổng quan',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: BarChart(
                        BarChartData(
                          maxY: 20,
                          //      titlesData: FlTitlesData(
                          //   show: true,
                          //   bottomTitles: SideTitles(
                          //     showTitles: true,
                          //     getTextStyles: (context, value) => const TextStyle(
                          //         color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                          //     margin: 20,
                          //     getTitles: (double value) {
                          //       switch (value.toInt()) {
                          //         case 0:
                          //           return 'Mn';
                          //         case 1:
                          //           return 'Te';
                          //         case 2:
                          //           return 'Wd';
                          //         case 3:
                          //           return 'Tu';
                          //         case 4:
                          //           return 'Fr';
                          //         case 5:
                          //           return 'St';
                          //         case 6:
                          //           return 'Sn';
                          //         default:
                          //           return '';
                          //       }
                          //     },
                          //   ),
                          //   leftTitles: SideTitles(
                          //     showTitles: true,
                          //     getTextStyles: (context, value) => const TextStyle(
                          //         color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                          //     margin: 32,
                          //     reservedSize: 14,
                          //     getTitles: (value) {
                          //       if (value == 0) {
                          //         return '1K';
                          //       } else if (value == 10) {
                          //         return '5K';
                          //       } else if (value == 19) {
                          //         return '10K';
                          //       } else {
                          //         return '';
                          //       }
                          //     },
                          //   ),
                          // ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: showingBarGroups,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 2, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }
}
