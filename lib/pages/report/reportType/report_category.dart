import 'dart:ui';
import 'package:Kaviet/api/report/reportService.dart';
import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/report/charts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Category {
  String name;
  double total_price;
  Category({this.name, this.total_price});
  static List category = <Category>[];
}

class ReportCategoryScreen extends StatelessWidget {
  const ReportCategoryScreen({Key key, this.startdate, this.enddate})
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
    List<Category> category = Category.category;
    List data = [];
    final oCcy = new NumberFormat("#,###", "en_US");

    ReportServices _reportServices = new ReportServices();
    SelectTimeReport _selectTimeReport = new SelectTimeReport();
    if (_selectTimeReport.startDate == null) {
      _selectTimeReport.startDate = startdate.millisecondsSinceEpoch / 1000;
      _selectTimeReport.endDate = enddate.millisecondsSinceEpoch / 1000;
    }
    return FutureBuilder<Map>(
        future: _reportServices.reportCategory(_selectTimeReport),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            snapshot.data.forEach((key, value) {
              if (key == "data") data.addAll(value);
            });
            data.forEach((element) {
              category.add(Category(
                  name: element['category_name'],
                  total_price:
                      double.parse(element['total_revenue'].toString())));
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
                                              'Tên danh mục mặt hàng',
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
                                  for (var i
                                      in Iterable.generate(category.length))
                                    TableRow(
                                      children: <Widget>[
                                        Container(
                                            height: 30,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                category[i].name,
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
                                                      .format(category[i]
                                                          .total_price)
                                                      .toString() +
                                                  " ₫",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              PieChartSample2(),
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
                child: Text(
                  'Đang tải dữ liệu ....',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ]);
          }
          return result;
        });
  }
}
