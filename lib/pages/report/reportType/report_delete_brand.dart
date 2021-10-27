import 'dart:ui';
import 'package:Kaviet/api/report/reportService.dart';
import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/home/Body/calendar_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDeleteBrandScreen extends StatelessWidget {
  const ReportDeleteBrandScreen({Key key, this.startdate, this.enddate})
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
                              children: <Widget>[
                                // getSearchBarUI(),
                                // getTimeDateUI(),
                              ],
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
    List<Products> brands = Products.products;
    List data = [];
    ReportServices _reportServices = new ReportServices();
    SelectTimeReport _selectTimeReport = new SelectTimeReport();
    if (_selectTimeReport.startDate == null) {
      _selectTimeReport.startDate = startdate.millisecondsSinceEpoch / 1000;
      _selectTimeReport.endDate = enddate.millisecondsSinceEpoch / 1000;
    }
    return FutureBuilder<Map>(
        future: _reportServices.reportDeleteBrand(_selectTimeReport),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            snapshot.data.forEach((key, value) {
              if (key == "data") data.addAll(value);
            });
            data.forEach((element) {
              brands.add(Products(
                  products_name: element['product_name'],
                  name: element['name'],
                  reason: element['reason_another'],
                  amount: int.parse(element['amount'].toString()),
                  time: element['created_at']));
            });
            if (data.length > 0)
              result = Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(100),
                  3: FixedColumnWidth(100),
                  4: FixedColumnWidth(50),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              'Thời gian',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                            height: 30,
                            width: 100,
                            child: Center(
                              child: Text(
                                'NV',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            height: 30,
                            width: 200,
                            child: Center(
                              child: Text(
                                'Tên ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            height: 30,
                            child: Center(
                              child: Text(
                                'Lý do ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            height: 30,
                            child: Center(
                              child: Text(
                                'SL ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                    ],
                  ),
                  for (var i in Iterable.generate(brands.length))
                    TableRow(
                      children: <Widget>[
                        Container(
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Text(
                                '${DateFormat("dd/M hh:mm").format(DateTime.fromMillisecondsSinceEpoch((brands[i].time) * 1000))}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              brands[i].name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              brands[i].products_name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              brands[i].reason,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(brands[i].amount.toString()),
                        ),
                      ],
                    )
                ],
              );
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

class Products {
  String name;
  int amount;
  var time;
  String reason;
  String products_name;
  Products(
      {this.name, this.amount, this.time, this.reason, this.products_name});
  static List products = <Products>[];
}
