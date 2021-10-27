import 'dart:ui';
import 'package:Kaviet/api/report/reportService.dart';
import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/home/Body/calendar_popup_view.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Products {
  String unit_name;
  int cur_amount;
  int add_amount;
  int sub_amount;
  String products_name;
  String material_name;
  Products(
      {this.unit_name,
      this.products_name,
      this.material_name,
      this.add_amount,
      this.cur_amount,
      this.sub_amount});
  static List products = <Products>[];
}

class ReportInventoryScreen extends StatelessWidget {
  const ReportInventoryScreen({
    Key key,
    this.startdate,
    this.enddate,
  }) : super(key: key);
  final DateTime startdate;
  final DateTime enddate;
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    List<BottomNavyBarItem> _labels = [
      BottomNavyBarItem(
        icon: Icon(Icons.inventory_2),
        title: Text('Hàng tồn'),
        activeColor: Colors.red,
        textAlign: TextAlign.center,
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.inventory_outlined),
        title: Text('Nguyên liệu'),
        activeColor: Colors.purpleAccent,
        textAlign: TextAlign.center,
      )
    ];
    int currentIndex = 0;

    ReportServices _reportServices = new ReportServices();
    SelectTimeReport _selectTimeReport = new SelectTimeReport();

    List<Products> brands = Products.products;
    List data = [];
    if (_selectTimeReport.startDate == null) {
      _selectTimeReport.startDate = startdate.millisecondsSinceEpoch / 1000;
      _selectTimeReport.endDate = enddate.millisecondsSinceEpoch / 1000;
    }
    _selectTimeReport.type = currentIndex == 1 ? "material" : "product";
    return FutureBuilder<Map>(
        future: _reportServices.reportProductsInventory(_selectTimeReport),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            snapshot.data.forEach((key, value) {
              if (key == "data") data.addAll(value);
            });
            data.forEach((element) {
              brands.add(Products(
                  products_name: element['product_name'] != null
                      ? element['product_name']
                      : "",
                  material_name:
                      element['material'] != null ? element['material'] : "",
                  unit_name: element['unit_name'],
                  cur_amount: int.parse(element['cur_amount'] != null
                      ? element['cur_amount'].toString()
                      : 0.toString()),
                  add_amount: int.parse(element['add_amount'] != null
                      ? element['add_amount'].toString()
                      : 0.toString()),
                  sub_amount: int.parse(element['sub_amount'] != null
                      ? element['sub_amount'].toString()
                      : 0.toString())));
            });
            if (data.length > 0)
              result = Scaffold(
                  body: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FixedColumnWidth(50),
                      3: FixedColumnWidth(50),
                      4: FixedColumnWidth(50),
                      5: FixedColumnWidth(50),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text(
                                  'Nguyên Liệu (Đơn vị)',
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
                                width: 100,
                                child: Center(
                                  child: Text(
                                    'SL Đầu',
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
                                    'SL Bán ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    'Thêm ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    'Giảm ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'SL Cuối ',
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
                                    brands[i].products_name != ""
                                        ? brands[i].products_name
                                        : brands[i].material_name,
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text(
                                  (int.parse(brands[i].cur_amount.toString()) +
                                          int.parse(
                                              brands[i].sub_amount.toString()) -
                                          int.parse(
                                              brands[i].add_amount.toString()))
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
                                  "0",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text(
                                  brands[i].add_amount.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(brands[i].sub_amount.toString()),
                            ),
                            Center(
                              child: Text(brands[i].cur_amount.toString()),
                            ),
                          ],
                        ),
                    ],
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: BottomNavyBar(
                        selectedIndex: currentIndex,
                        showElevation: true,
                        itemCornerRadius: 24,
                        curve: Curves.easeIn,
                        onItemSelected: (index) => {
                              currentIndex = index,
                            },
                        items: _labels),
                  ));
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
