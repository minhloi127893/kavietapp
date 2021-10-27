import 'package:Kaviet/model/report/selectDate_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Services {
  String summary;
  String staff;
  String category;
  String trendingBrand;
  String trendingSubBrand;
  String deleteBrand;
  String discount;
  String inventory;
  Services(
      {this.summary,
      this.staff,
      this.category,
      this.trendingBrand,
      this.trendingSubBrand,
      this.deleteBrand,
      this.discount,
      this.inventory});
}

class ReportServices {
  Services _services = Services(
      summary: "income-billing-form",
      staff: "income-user",
      category: "income-category",
      trendingBrand: "top-product-selling",
      trendingSubBrand: "top-product-selling",
      deleteBrand: "deleteproduct",
      discount: "discount",
      inventory: "inventory");

  Future<Map> reportSummary(SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.summary;
    var url = Uri.parse(
        "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate");
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

  Future<Map> reportStaff(SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.staff;
    var url = Uri.parse(
        "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate");
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

  Future<Map> reportCategory(SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.category;

    var url = Uri.parse(
        "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate");
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

  Future<Map> reportTrendingBrand(SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.trendingBrand;

    var url = Uri.parse(
        "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate&is_main=true");
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

  Future<Map> reportTrendingSubBrand(SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.trendingSubBrand;
    var url = Uri.parse(
        "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate&is_main=true");
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

  Future<Map> reportDeleteBrand(SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.deleteBrand;
    var url = Uri.parse(
        "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate");
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

  Future<Map> reportDiscount(SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.discount;

    var url = Uri.parse(
        "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate");
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

  Future<Map> reportProductsInventory(
      SelectTimeReport _selectTimeReport) async {
    var startdate = _selectTimeReport.startDate;
    var enddate = _selectTimeReport.endDate;
    var services = _services.inventory;
    String type = _selectTimeReport.type;
    var url = Uri.parse("https://kaviet.vn/api/v1/report/$services/$type");
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

  // Future<Map> reportMaterialInventory(
  //     SelectTimeReport _selectTimeReport) async {
  //   var startdate = _selectTimeReport.startDate;
  //   var enddate = _selectTimeReport.endDate;
  //   var services = _services.material_inventory;
  //   var url = Uri.parse(
  //       "https://kaviet.vn/api/v1/report/$services?start_date=$startdate&end_date=$enddate");
  //   final storage = new FlutterSecureStorage();
  //   var tk = await storage.read(key: "token");
  //   final response = await http.get(url, headers: {
  //     'X-Requested-With': 'XMLHttpRequest',
  //     'Authorization': 'Bearer ' + tk
  //   });
  //   if (response.statusCode == 200 || response.statusCode == 400) {
  //     var jsonData = json.decode(response.body);
  //     return jsonData;
  //   } else {
  //     throw Exception('Failed to load data!');
  //   }
  // }
}
