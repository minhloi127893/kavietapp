import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/login/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    var url = Uri.parse("https://kaviet.vn/api/v1/auth/login");
    // var url1 = Uri.parse("https://kaviet.vn/api/v1/auth/login-staff");

    final response = await http.post(url, body: {
      "phonenumber": requestModel.phonenumber,
      "username": requestModel.username,
      "password": requestModel.password
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
      // return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
