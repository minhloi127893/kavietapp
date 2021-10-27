import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InventoryServices {
  Future<Map> products() async {
    var url =
        Uri.parse("https://kaviet.vn/api/v1/history/inventory/all/product");
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

  Future<Map> material() async {
    var url =
        Uri.parse("https://kaviet.vn/api/v1/history/inventory/all/material");
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
