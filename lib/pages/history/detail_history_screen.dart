import 'dart:ui';
import 'package:Kaviet/api/history/historyService.dart';
import 'package:Kaviet/pages/home/home_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:expandable/expandable.dart';

class Data {
  String title;
  String data;
  Data({
    @required this.title,
    @required this.data,
  });
}

class DetailHistoryScreen extends StatelessWidget {
  const DetailHistoryScreen({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    final oCcy = new NumberFormat("#,###", "en_US");

    List<Data> _totals = [];
    List<Data> _datas = [];
    List _brands = [];
    final ScrollController _scrollController = ScrollController();
    HisotyServices _services = new HisotyServices();
    return FutureBuilder<Map>(
        future: _services.detailhistory(id),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            _totals.clear();
            _datas.clear();
            _brands.clear();
            snapshot.data.forEach((key, value) {
              if (key == "data") {
                _totals.add(Data(
                    title: value['discount'] != null
                        ? value['discount']['discount_name']
                        : "Khuyến mãi",
                    data: value['discount'] != null
                        ? value['discount']['money_discount']
                        : 0.toString()));
                _totals
                    .add(Data(title: "Thanh toán", data: value['total_price']));
                _totals.add(Data(title: "Tổng", data: value['total_price']));
                _brands.addAll(value['products']);
                _datas.add(Data(
                    title: "Loại",
                    data: value['selling_form']['id'] == 2
                        ? value['selling_form']['name']
                        : value['table']['area_name'] +
                            " -" +
                            value['table']['name']));
                _datas.add(
                    Data(title: "Phục vụ bởi", data: value['user']['name']));
                _datas.add(
                    Data(title: "Thanh toán bởi", data: value['user']['name']));
                _datas.add(Data(
                    title: "Thời gian",
                    data: DateFormat("dd/M/y").format(
                        DateTime.fromMillisecondsSinceEpoch(
                            value['pay_date'] * 1000))));
                _datas.add(
                    Data(title: "Số biên lai", data: value['invoice_code']));
              }
            });
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
                                        "Hoá đơn " +
                                            oCcy
                                                .format(int.parse(
                                                    _totals[2].data.toString()))
                                                .toString() +
                                            " ₫",
                                        style: TextStyle(
                                          fontFamily: "Raleway",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
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
                                                    _datas[index].data,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
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
                                                tapBodyToCollapse: true,
                                              ),
                                              header: ListTile(
                                                title: Text(
                                                  "Mặt hàng",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                trailing: Text(
                                                  oCcy
                                                          .format(int.parse(
                                                              _totals[2]
                                                                  .data
                                                                  .toString()))
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
                                                  for (var _
                                                      in Iterable.generate(1))
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
                                                          _brands.length,
                                                          (index) => ListTile(
                                                            leading: Icon(
                                                              Icons.circle,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            title: Text(
                                                              _brands[index][
                                                                      'product_name'] +
                                                                  " x" +
                                                                  _brands[index]
                                                                          [
                                                                          'amount']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            trailing: Text(
                                                              oCcy
                                                                      .format(int.parse(_brands[index]
                                                                              [
                                                                              'sum_price']
                                                                          .toString()))
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
                                                          .format(int.parse(
                                                              _totals[index]
                                                                  .data
                                                                  .toString()))
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
          } else {
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
                      child: Center(
                          child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top * 8,
                              left: 8,
                              right: 8),
                        ),
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
                      ])))
                ]))));
          }
          return result;
        });
  }
}
