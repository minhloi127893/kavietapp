import 'package:Kaviet/pages/home/home_page.dart';
import 'package:Kaviet/pages/inventory/inventoryType/material_inventory.dart';
import 'package:Kaviet/pages/inventory/inventoryType/products_inventory.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class Pages {
  String title;
  var pages;
  Pages({this.title, this.pages});
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int _currentIndex = 0;

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
  List<Pages> _Pages = [
    Pages(title: "Hàng tồn", pages: ProductsInventoryScreen()),
    Pages(title: "Nguyên liệu", pages: MaterialInventoryScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: getAppBarUI(),
        ),
        body: _Pages[_currentIndex].pages,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: BottomNavyBar(
              selectedIndex: _currentIndex,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              onItemSelected: (index) => setState(() => _currentIndex = index),
              items: _labels),
        ));
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
              width: AppBar().preferredSize.height + 20,
              height: AppBar().preferredSize.height,
            ),
            Expanded(
              child: Center(
                  child: ListTile(
                title: Text(
                  _Pages[_currentIndex].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top / 2.5,
                      left: 8,
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
