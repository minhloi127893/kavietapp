import 'dart:ui';
import 'package:Kaviet/api/report/reportService.dart';
import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/home/Body/calendar_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Sales {
  String discount_name;
  int money_discount;
  double sum_discount;
  String is_percent;
  int amount;
  Sales(
      {this.discount_name,
      this.is_percent,
      this.amount,
      this.money_discount,
      this.sum_discount});
  static List sales = <Sales>[];
}

class ReportDiscountScreen extends StatelessWidget {
  const ReportDiscountScreen({
    Key key,
    this.startdate,
    this.enddate,
  }) : super(key: key);
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
    final oCcy = new NumberFormat("#,###", "en_US");

    ReportServices _reportServices = new ReportServices();
    SelectTimeReport _selectTimeReport = new SelectTimeReport();

    List<Sales> sales = Sales.sales;
    List data = [];
    if (_selectTimeReport.startDate == null) {
      _selectTimeReport.startDate = startdate.millisecondsSinceEpoch / 1000;
      _selectTimeReport.endDate = enddate.millisecondsSinceEpoch / 1000;
    }
    return FutureBuilder<Map>(
        future: _reportServices.reportDiscount(_selectTimeReport),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            snapshot.data.forEach((key, value) {
              if (key == "data") data.addAll(value);
            });
            data.forEach((element) {
              sales.add(Sales(
                  discount_name: element['discount_name'],
                  is_percent:
                      element['is_percent'] == 0 ? "(Thành Tiền)" : "(%)",
                  money_discount:
                      int.parse(element['money_discount'].toString()),
                  amount: int.parse(element['amount'].toString()),
                  sum_discount:
                      double.parse(element['sum_discount'].toString())));
            });
            if (data.length > 0)
              result = Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(50),
                  3: FixedColumnWidth(100),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              'Tên giảm giá',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                            height: 30,
                            width: 100,
                            child: Center(
                              child: Text(
                                'Loại giảm giá',
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
                                'SL',
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
                            height: 50,
                            child: Center(
                              child: Text(
                                'Tổng số giảm giá ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ),
                  for (var i in Iterable.generate(sales.length))
                    TableRow(
                      children: <Widget>[
                        Container(
                            height: 50,
                            width: 100,
                            child: Center(
                              child: Text(
                                sales[i].discount_name,
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              "- " +
                                  oCcy
                                      .format(sales[i].money_discount)
                                      .toString() +
                                  " ₫ " +
                                  sales[i].is_percent,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              sales[i].amount.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(
                              "- " +
                                  oCcy
                                      .format(sales[i].sum_discount)
                                      .toString() +
                                  " ₫ ",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
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
