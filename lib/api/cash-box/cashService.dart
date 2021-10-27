import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CashServices {
  Future<Map> cash() async {
    var url = Uri.parse("https://kaviet.vn/api/v1/cash-box/cashier-history");
    final storage = new FlutterSecureStorage();
    var tk = await storage.read(key: "token");
    final response = await http.get(url, headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ' + tk
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<Map> detailhistory(int id) async {
    var url = Uri.parse("https://kaviet.vn/api/v1/cost/history-cost/$id");
    final storage = new FlutterSecureStorage();
    var tk = await storage.read(key: "token");
    final response = await http.get(url, headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ' + tk
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
