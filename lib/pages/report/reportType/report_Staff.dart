import 'dart:ui';
import 'package:Kaviet/api/report/reportService.dart';
import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/report/charts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Staff {
  String name;
  int total_price;
  Staff({this.name, this.total_price});
  static List user = <Staff>[];
}

class ReportStaffScreen extends StatelessWidget {
  const ReportStaffScreen({Key key, this.startdate, this.enddate})
      : super(key: key);
  final DateTime startdate;
  final DateTime enddate;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[],
                            );
                          }, childCount: 1),
                        ),
                      ];
                    },
                    body: bodypages(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bodypages() {
    final SelectTimeReport _selectTimeReport = new SelectTimeReport();
    final ReportServices _reportServices = new ReportServices();
    List<Staff> user = Staff.user;
    List data = [];
    final oCcy = new NumberFormat("#,###", "en_US");
    if (_selectTimeReport.startDate == null) {
      _selectTimeReport.startDate = startdate.millisecondsSinceEpoch / 1000;
      _selectTimeReport.endDate = enddate.millisecondsSinceEpoch / 1000;
    }
    return FutureBuilder<Map>(
        future: _reportServices.reportStaff(_selectTimeReport),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            snapshot.data.forEach((key, value) {
              if (key == "data") data.addAll(value);
            });
            data.forEach((element) {
              user.add(Staff(
                  name: element['name'],
                  total_price: int.parse(element['total_price'].toString())));
            });
            if (data.length > 0)
              result = DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyText2,
                  child: LayoutBuilder(builder: (BuildContext context,
                      BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: Column(
                            children: [
                              Table(
                                border: TableBorder.all(),
                                columnWidths: const <int, TableColumnWidth>{
                                  0: FlexColumnWidth(),
                                  1: FlexColumnWidth(),
                                },
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(
                                    children: <Widget>[
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: Text(
                                              'Tên Nhân Viên',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Container(
                                            height: 30,
                                            width: 200,
                                            child: Center(
                                              child: Text(
                                                'Tổng doanh thu ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  for (var i in Iterable.generate(user.length))
                                    TableRow(
                                      children: <Widget>[
                                        Container(
                                            height: 30,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                user[i].name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Center(
                                            child: Text(
                                              oCcy
                                                      .format(
                                                          user[i].total_price)
                                                      .toString() +
                                                  " đ",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              BarChartSample2(),
                            ],
                          ),
                        ));
                  }));
            else
              result = Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      'Không có dữ liệu ....',
                      style: TextStyle(fontSize: 20),
                    ),
                  ));
          } else {
            result = Column(children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 16),
              //   child: Text('Awaiting result...'),
              // )
            ]);
          }
          return result;
        });
  }
}
