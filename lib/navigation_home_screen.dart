import 'package:Kaviet/app_theme.dart';
import 'package:Kaviet/pages/cash-box/history_cash_screen.dart';
import 'package:Kaviet/pages/custom_drawer/drawer_user_controller.dart';
import 'package:Kaviet/pages/custom_drawer/home_drawer.dart';
import 'package:Kaviet/pages/history/history_screen.dart';
import 'package:Kaviet/pages/report/report_screen.dart';
import 'package:Kaviet/pages/home/home_page.dart';
import 'package:Kaviet/pages/inventory/history_inventory_screen.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, HistoryScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = HomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.Report) {
        setState(() {
          screenView = ReportScreen();
        });
      } else if (drawerIndex == DrawerIndex.History) {
        setState(() {
          screenView = HistoryHomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.Inventory) {
        setState(() {
          screenView = InventoryScreen();
        });
      } else if (drawerIndex == DrawerIndex.Shift) {
        setState(() {
          screenView = HistoryCashScreen();
        });
      }
    }
  }
}
