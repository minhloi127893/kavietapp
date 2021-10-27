import 'dart:ui';
import 'package:Kaviet/pages/history/history_list_view.dart';
import 'package:Kaviet/pages/history/model/history_list_data.dart';
import 'package:Kaviet/pages/report/charts.dart';
import 'package:flutter/material.dart';
import '../home_app_theme.dart';
import '../../../main.dart';

class HomePaegsBodyScreen extends StatefulWidget {
  @override
  _HomePaegsBodyScreenState createState() => _HomePaegsBodyScreenState();
}

class _HomePaegsBodyScreenState extends State<HomePaegsBodyScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<HistoryListData> historyList = HistoryListData.historyList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: [
                // BarChartSample2(),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        "Không có dữ liệu",
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
              ],
            ),
          ));
        }));
  }
}
