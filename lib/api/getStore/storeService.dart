import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/login/login_model.dart';

class GetStoreServices {
  Future<Map> get_store() async {
    var url = Uri.parse("https://kaviet.vn/api/v1/store/get-store");

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
