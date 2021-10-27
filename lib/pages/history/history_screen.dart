import 'dart:ui';
import 'package:Kaviet/api/history/historyService.dart';
import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/history/history_list_view.dart';
import 'package:Kaviet/pages/history/model/history_list_data.dart';
import 'package:Kaviet/pages/home/Body/calendar_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../home/home_app_theme.dart';

class HistoryHomeScreen extends StatefulWidget {
  @override
  _HistoryHomeScreenState createState() => _HistoryHomeScreenState();
}

class _HistoryHomeScreenState extends State<HistoryHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<HistoryListData> historyList = HistoryListData.historyList;
  HisotyServices _services = new HisotyServices();
  final ScrollController _scrollController = ScrollController();
  List data = [];
  int _timenow = new DateTime.now().millisecondsSinceEpoch;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HomeAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
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
                    getAppBarUI(),
                    getSearchBarUI(),
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
                                    Text(
                                      '${DateFormat("dd/M/y").format(DateTime.fromMillisecondsSinceEpoch((historyList.length > 0 ? historyList[0].pay_date * 1000 : _timenow)))}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.8)),
                                    )
                                  ],
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
        ),
      ),
    );
  }

  Widget bodypages() {
    return FutureBuilder<Map>(
        future: _services.history(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            snapshot.data['data'].forEach((key, value) {
              if (key == "data") data.addAll(value);
            });
            historyList.clear();
            data.forEach((element) {
              historyList.add(HistoryListData(
                  invoice_code: element['invoice_code'].toString(),
                  pay_date: int.parse(element['pay_date'].toString()),
                  total_price: double.parse(element['total_price'].toString()),
                  id: int.parse(element['id'].toString())));
            });
            if (data.length > 0)
              result = Container(
                color: HomeAppTheme.buildLightTheme().backgroundColor,
                child: ListView.builder(
                  itemCount: historyList.length,
                  padding: const EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final int count =
                        historyList.length > 10 ? 10 : historyList.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController?.forward();
                    return HistoryListView(
                      callback: () {},
                      historyData: historyList[index],
                      animation: animation,
                      animationController: animationController,
                    );
                  },
                ),
              );
            else
              result = Center(
                child: Text(
                  'Không có dữ liệu ....',
                  style: TextStyle(fontSize: 20),
                ),
              );
          } else {
            result = Center(
              child: Column(children: <Widget>[
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
              ]),
            );
          }
          return result;
        });
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HomeAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: historyList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          historyList.length > 10 ? 10 : historyList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HistoryListView(
                        callback: () {},
                        historyData: historyList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHistoryViewList() {
    final List<Widget> historyListViews = <Widget>[];
    for (int i = 0; i < historyList.length; i++) {
      final int count = historyList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      historyListViews.add(
        HistoryListView(
          callback: () {},
          historyData: historyList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: historyListViews,
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HomeAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {
                      if (txt == historyList[0].total_price) print(txt);
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HomeAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tìm kiếm hoá đơn ...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HomeAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  print("search");
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: HomeAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
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
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            ),
            Expanded(
              child: Center(
                  child: ListTile(
                title: Text(
                  "Lịch sử hoá đơn",
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
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
