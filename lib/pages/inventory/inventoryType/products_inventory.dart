import 'package:Kaviet/api/inventory/inventoryService.dart';
import 'package:Kaviet/pages/home/home_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProductsInventoryScreen extends StatefulWidget {
  @override
  _ProductsInventoryScreenState createState() =>
      _ProductsInventoryScreenState();
}

class Products {
  Products({this.reason, this.amount, this.proName, this.staffName, this.time});
  String reason;
  int amount;
  String proName;
  String staffName;
  var time;

  static List products = <Products>[];
}

class _ProductsInventoryScreenState extends State<ProductsInventoryScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  InventoryServices _services = new InventoryServices();
  List<Products> products = Products.products;
  List data = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: _services.products(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          Widget result = Container();
          if (snapshot.hasData) {
            snapshot.data['data'].forEach((key, value) {
              //
              if (key == "data") data.addAll(value);
            });
            products.clear();
            data.forEach((element) {
              products.add(Products(
                  time: element['updated_at'],
                  proName: element['product']['product_name'],
                  staffName: element['user']['name'],
                  amount: int.parse(element['amount'] != null
                      ? element['amount'].toString()
                      : 0.toString()),
                  reason: element['reason_another']));
            });

            result = Scaffold(
              body: Stack(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
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
                                        getSearchBarUI(),
                                      ],
                                    );
                                  }, childCount: 1),
                                ),
                              ];
                            },
                            body: Table(
                              border: TableBorder.all(),
                              columnWidths: const <int, TableColumnWidth>{
                                0: IntrinsicColumnWidth(),
                                1: FlexColumnWidth(),
                                2: FixedColumnWidth(100),
                                3: FixedColumnWidth(100),
                                4: FixedColumnWidth(50),
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
                                            'Th???i gian',
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
                                              'NV',
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
                                              'T??n ',
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
                                              'L?? do ',
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
                                              'SL ',
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
                                for (var i
                                    in Iterable.generate(products.length))
                                  TableRow(
                                    children: <Widget>[
                                      Container(
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              '${DateFormat("dd/M hh:mm").format(DateTime.fromMillisecondsSinceEpoch((products[i].time) * 1000))}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: Text(
                                            products[i].staffName,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: Text(
                                            products[i].proName,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Center(
                                          child: Text(
                                            products[i].reason,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child:
                                            Text(products[i].amount.toString()),
                                      ),
                                    ],
                                  )
                              ],
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
          return result;
        });
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
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HomeAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'T??m ki???m m???t h??ng...',
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
}
