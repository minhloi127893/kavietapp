import 'dart:ui';
import 'package:Kaviet/api/cash-box/cashService.dart';
import 'package:Kaviet/pages/home/home_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expandable/expandable.dart';

class Data {
  String title;
  int data;
  Data({
    @required this.title,
    @required this.data,
  });
}

List<Data> _totals = [];
List<Data> _datas = [];

List _cost = [];
List _listPay = [];
List _listCollect = [];
int id = 2;
Data _pay = Data(title: "", data: 0);
Data _collect = Data(title: "", data: 0);
Data _time = Data(title: "", data: 0);

class DetailShiftScreen extends StatelessWidget {
  const DetailShiftScreen({Key key, this.id}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    final oCcy = new NumberFormat("#,###", "en_US");
    final ScrollController _scrollController = ScrollController();
    CashServices _services = new CashServices();
    return FutureBuilder<Map>(
        future: _services.detailhistory(id),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            _totals.clear();
            _datas.clear();
            _cost.clear();
            _listCollect.clear();
            _listPay.clear();
            _pay.data = 0;
            _collect.data = 0;
            snapshot.data.forEach((key, value) {
              if (key == "data") {
                _totals.add(Data(
                    title: "Số tiền dự kiến",
                    data: int.parse(value['money_expected'].toString())));
                _datas.add(Data(
                    title: "Tiền mặt đầu kỳ",
                    data: int.parse(value['money_first'].toString())));
                _datas.add(Data(
                    title: "Doanh thu tiền mặt",
                    data: int.parse(value['income_total'].toString())));
                _time = (Data(title: "Thời gian", data: value['created_at']));
                _cost.addAll(value['costs']);
              }
            });

            if (_cost.length > 0) {
              _cost.forEach((element) {
                if (element['is_pay'] == true) {
                  _listPay.add(Data(
                      title: element['description'],
                      data: element['price'] != null
                          ? int.parse(element['price'].toString())
                          : 0));
                  _pay.data = _listPay.fold(0,
                      (previousValue, element) => previousValue + element.data);
                } else if (element['is_pay'] == false) {
                  _listCollect.add(Data(
                      title: element['description'],
                      data: element['price'] != null
                          ? int.parse(element['price'].toString())
                          : 0));
                  _collect.data = _listCollect.fold(0,
                      (previousValue, element) => previousValue + element.data);
                }
              });
            }
            result = Theme(
                data: HomeAppTheme.buildLightTheme(),
                child: Container(
                    child: Scaffold(
                        body: Stack(children: <Widget>[
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
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: const Offset(0, 2),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top,
                                  left: 8,
                                  right: 8),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: AppBar().preferredSize.height + 40,
                                    height: AppBar().preferredSize.height,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(32.0),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.arrow_back),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                        child: ListTile(
                                      title: Text(
                                        'Chi tiết ${DateFormat("dd/MM/y HH:mm").format(DateTime.fromMillisecondsSinceEpoch((int.parse(_time.data.toString())) * 1000))}',
                                        style: TextStyle(
                                          fontFamily: "Raleway",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: NestedScrollView(
                                  controller: _scrollController,
                                  headerSliverBuilder: (BuildContext context,
                                      bool innerBoxIsScrolled) {
                                    return <Widget>[
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: <Widget>[
                                              // getSearchBarUI(),
                                            ],
                                          );
                                        }, childCount: 1),
                                      ),
                                    ];
                                  },
                                  body: SingleChildScrollView(
                                    child: ExpandableNotifier(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Column(
                                              children: List.generate(
                                                _datas.length,
                                                (index) => ListTile(
                                                  title: Text(
                                                    _datas[index].title,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  trailing: Text(
                                                    oCcy
                                                            .format(
                                                                _datas[index]
                                                                    .data)
                                                            .toString() +
                                                        " đ",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: ListTile(
                                              title: Text(
                                                _time.title,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              trailing: Text(
                                                '${DateFormat("dd/MM/y HH:mm").format(DateTime.fromMillisecondsSinceEpoch((int.parse(_time.data.toString())) * 1000))}',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          ScrollOnExpand(
                                            scrollOnExpand: true,
                                            scrollOnCollapse: false,
                                            child: ExpandablePanel(
                                              theme: const ExpandableThemeData(
                                                headerAlignment:
                                                    ExpandablePanelHeaderAlignment
                                                        .center,
                                                tapBodyToCollapse: false,
                                              ),
                                              header: ListTile(
                                                title: Text(
                                                  "Thu",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                trailing: Text(
                                                  oCcy
                                                          .format(_collect.data)
                                                          .toString() +
                                                      " đ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              collapsed: Text(
                                                "",
                                              ),
                                              expanded: Column(
                                                children: <Widget>[
                                                  Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    child: Column(
                                                      children: List.generate(
                                                        _listCollect.length,
                                                        (index) => ListTile(
                                                          leading: Icon(
                                                            Icons.add_circle,
                                                            color: Colors.black,
                                                          ),
                                                          title: Text(
                                                            _listCollect[index]
                                                                .title,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          trailing: Text(
                                                            oCcy
                                                                    .format(_listCollect[
                                                                            index]
                                                                        .data)
                                                                    .toString() +
                                                                " đ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              builder:
                                                  (_, collapsed, expanded) {
                                                return Expandable(
                                                  collapsed: collapsed,
                                                  expanded: expanded,
                                                  theme:
                                                      const ExpandableThemeData(
                                                          crossFadePoint: 0),
                                                );
                                              },
                                            ),
                                          ),
                                          ScrollOnExpand(
                                            scrollOnExpand: true,
                                            scrollOnCollapse: false,
                                            child: ExpandablePanel(
                                              theme: const ExpandableThemeData(
                                                headerAlignment:
                                                    ExpandablePanelHeaderAlignment
                                                        .center,
                                                tapBodyToCollapse: false,
                                              ),
                                              header: ListTile(
                                                title: Text(
                                                  "Trả tiền",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                trailing: Text(
                                                  oCcy
                                                          .format(_pay.data)
                                                          .toString() +
                                                      " đ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              collapsed: Text(
                                                "",
                                              ),
                                              expanded: Column(
                                                children: <Widget>[
                                                  Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    child: Column(
                                                      children: List.generate(
                                                        _listPay.length,
                                                        (index) => ListTile(
                                                          leading: Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.black,
                                                          ),
                                                          title: Text(
                                                            _listPay[index]
                                                                .title,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          trailing: Text(
                                                            oCcy
                                                                    .format(_listPay[
                                                                            index]
                                                                        .data)
                                                                    .toString() +
                                                                " đ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              builder:
                                                  (_, collapsed1, expanded1) {
                                                return Expandable(
                                                  collapsed: collapsed1,
                                                  expanded: expanded1,
                                                  theme:
                                                      const ExpandableThemeData(
                                                          crossFadePoint: 0),
                                                );
                                              },
                                            ),
                                          ),
                                          Column(
                                            children: List.generate(
                                              _totals.length,
                                              (index) => ListTile(
                                                title: Text(
                                                  _totals[index].title,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                trailing: Text(
                                                  oCcy
                                                          .format(_totals[index]
                                                              .data)
                                                          .toString() +
                                                      " đ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))),
                        ],
                      ))
                ]))));
          }
          return result;
        });
  }
}
