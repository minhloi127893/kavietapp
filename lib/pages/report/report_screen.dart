import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:Kaviet/pages/home/Body/calendar_popup_view.dart';
import 'package:Kaviet/pages/report/reportType/report_category.dart';
import 'package:Kaviet/pages/report/reportType/report_Overview.dart';
import 'package:Kaviet/pages/report/reportType/report_Staff.dart';
import 'package:Kaviet/pages/report/reportType/report_delete_brand.dart';
import 'package:Kaviet/pages/report/reportType/report_discount.dart';
import 'package:Kaviet/pages/report/reportType/report_inventory.dart';
import 'package:Kaviet/pages/report/reportType/report_trending_SubBrand.dart';
import 'package:Kaviet/pages/report/reportType/report_trending_brand.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class Pages {
  var pages;
  Pages({this.pages});
}

class _ReportScreenState extends State<ReportScreen> {
  SelectTimeReport selectTimeReport = new SelectTimeReport();

  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int currentIndex = 0;

  List<Text> _label = [
    Text(
      "Doanh thu tổng quan",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
    Text(
      "Doanh thu theo nhân viên",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
    Text(
      "Doanh thu theo doanh mục",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
    Text(
      "Mặt hàng bán chạy",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
    Text(
      "Mặt hàng tuỳ chỉnh",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
    Text(
      "Mặt hàng đã xoá",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
    Text(
      "Mặt hàng tồn kho",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
    Text(
      "Giảm giá áp dụng",
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Pages> _labels = [
      Pages(
          pages: ReportOverviewScreen(
        startdate: startDate,
        enddate: endDate,
      )),
      Pages(
          pages: ReportStaffScreen(
        startdate: startDate,
        enddate: endDate,
      )),
      Pages(
          pages: ReportCategoryScreen(
        startdate: startDate,
        enddate: endDate,
      )),
      Pages(
          pages: ReportTrendingBrandScreen(
        startdate: startDate,
        enddate: endDate,
      )),
      Pages(
          pages: ReportTrendingSubBrandScreen(
        startdate: startDate,
        enddate: endDate,
      )),
      Pages(
          pages: ReportDeleteBrandScreen(
        startdate: startDate,
        enddate: endDate,
      )),
      Pages(
          pages: ReportInventoryScreen(
        startdate: startDate,
        enddate: endDate,
      )),
      Pages(
          pages: ReportDiscountScreen(
        startdate: startDate,
        enddate: endDate,
      )),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: getAppBarUI(),
      ),
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
                            return Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    DefaultTabController(
                                      length: _labels.length,
                                      child: TabBar(
                                        indicator: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                40), // Creates border
                                            color: Colors.greenAccent),
                                        isScrollable: true,
                                        tabs: _label,
                                        onTap: (index) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                      ),
                                      initialIndex: 0,
                                    ),
                                    getTimeDateUI(),
                                  ],
                                ));
                          }, childCount: 1),
                        ),
                      ];
                    },
                    body: _labels[currentIndex].pages,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.black.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Chọn ngày',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 4.0, right: 4.0)),
                          Text(
                            '${DateFormat("dd/M/y").format(startDate)} - ${DateFormat("dd/M/y").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDemoDialog({BuildContextcontext}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        // minimumDate: DateTime.now(),
        maximumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
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
            Expanded(
              child: Center(
                  child: ListTile(
                title: Text(
                  "Báo cáo",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top / 2.5,
                      left: 15,
                      right: 8),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
