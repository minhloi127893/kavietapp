class LoginResponseModel {
  final String token;
  final String error;
  final user;
  LoginResponseModel({this.token, this.error, this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    String tokenjson = "";
    String userjson;
    if (json['success'] == true) {
      tokenjson = json['data']['access_token'] != null
          ? json['data']['access_token']
          : '';
      userjson =
          json['data']['user'] != null ? json['data']['user']['name'] : '';
    }
    return LoginResponseModel(
        token: tokenjson,
        user: userjson,
        error: json["messages"] != null ? json["messages"] : "");
  }
}

class LoginRequestModel {
  String username;
  String password;
  String phonenumber;
  // String type;

  LoginRequestModel({
    // this.type,
    this.username,
    this.password,
    this.phonenumber,
  });

  Map<String, String> toJson() {
    Map<String, String> map = {
      'username': username.toString(),
      'password': password.toString(),
      'phonenumber': phonenumber.toString(),
    };

    return map;
  }
}
