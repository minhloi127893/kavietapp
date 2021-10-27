import 'dart:ui';
import 'package:Kaviet/api/report/reportService.dart';
import 'package:Kaviet/model/report/report_model.dart';
import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/report/charts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Bill bill_not_payment;
Bill billing_summary1 = Bill(name: "Mang đi", total_bill: 0, total_price: 0);
Bill billing_summary2 =
    Bill(name: "Dùng tại bàn", total_bill: 0, total_price: 0);
// List<Bill> billing_hour = Bill.bill;
List bill1 = [];

class ReportOverviewScreen extends StatelessWidget {
  const ReportOverviewScreen({Key key, this.startdate, this.enddate})
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
                ),
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
    final SelectTimeReport selectTimeReport = new SelectTimeReport();
    selectTimeReport.startDate = startdate.millisecondsSinceEpoch / 1000;
    selectTimeReport.endDate = enddate.millisecondsSinceEpoch / 1000;
    return FutureBuilder<Map>(
      future: _reportServices.reportSummary(selectTimeReport),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        Widget result = Container();
        if (snapshot.hasData) {
          snapshot.data.forEach((key, value) {
            if (key == "data") {
              bill_not_payment = Bill(
                  sum_table: int.parse(
                      value['bill_not_payment']['sum_table'].toString()),
                  sum_price: int.parse(
                      value['bill_not_payment']['sum_price'].toString()));
              bill1.addAll(value['billing_summary']);
            }
          });
          bill1.forEach((element) {
            if (element['form_id'] == 2) {
              billing_summary1 = Bill(
                  form_id: int.parse(element['form_id'].toString()),
                  name: element['form_name'],
                  total_bill: int.parse(element['total_bill'].toString()),
                  total_price: double.parse(element['total_price'].toString()));
            }
            if (element['form_id'] == 1) {
              billing_summary2 = Bill(
                  form_id: int.parse(element['form_id'].toString()),
                  name: element['form_name'],
                  total_bill: int.parse(element['total_bill'].toString()),
                  total_price: double.parse(element['total_price'].toString()));
            }
          });

          int totalBill =
              billing_summary1.total_bill + billing_summary2.total_bill;
          double totalPrice =
              billing_summary1.total_price + billing_summary2.total_price;
          int summaryBill = totalBill + bill_not_payment.sum_table;
          double summaryPrice = totalPrice + bill_not_payment.sum_price;
          if (summaryBill == 0)
            result = DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText2,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
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
                                1: FixedColumnWidth(80),
                                2: FlexColumnWidth(),
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
                                            'Loại',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.top,
                                      child: Container(
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              'Giao dịch',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Container(
                                          height: 30,
                                          width: 200,
                                          child: Center(
                                            child: Text(
                                              'Tổng số tiền thu được ',
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
                                // for (var _ in Iterable.generate(1))
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            'Chưa Thanh Toán',
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
                                          bill_not_payment.sum_table.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          oCcy
                                                  .format(bill_not_payment
                                                      .sum_price)
                                                  .toString() +
                                              " đ",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            'Đã Thanh Toán',
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
                                          totalBill.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          oCcy.format(totalPrice).toString() +
                                              " đ",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            billing_summary2.name,
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
                                          billing_summary2.total_bill
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          oCcy
                                              .format(
                                                  billing_summary2.total_price)
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            billing_summary1.name,
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
                                          billing_summary1.total_bill
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          oCcy
                                                  .format(billing_summary1
                                                      .total_price)
                                                  .toString() +
                                              " đ",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                        height: 40,
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            'Tổng Doanh Thu Tạm Tính',
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
                                          summaryBill.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          oCcy.format(summaryPrice).toString() +
                                              " ₫",
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
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Đang tải dữ liệu', style: TextStyle(fontSize: 20)),
            )
          ]);
        }
        return result;
      },
    );
  }
}
