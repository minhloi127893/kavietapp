import 'package:Kaviet/navigation_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Kaviet/api/login/loginService.dart';
import 'package:Kaviet/model/login/login_model.dart';
import '../../ProgressHUD.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = new FlutterSecureStorage();

  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future write(token, user) async {
    storage.write(key: "token", value: token);
    storage.write(key: "user", value: user);
  }

  Future delete() async {
    storage.deleteAll();
  }

  Future read() async {
    try {
      String tk = await storage.read(key: "token");
      if (tk != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    read();
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Image.asset('images/logo_kaviet_web.png'),
                        // DefaultTabController(
                        //   length: 2,
                        //   child: TabBar(
                        //     indicator: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.circular(50), // Creates border
                        //         color: Colors.greenAccent),
                        //     tabs: [
                        //       Tab(
                        //         text: "Ch??? c???a h??ng",
                        //       ),
                        //       Tab(
                        //         text: "Nh??n vi??n",
                        //       ),
                        //     ],
                        //     onTap: (index) {
                        //       if (index == 0)
                        //         loginRequestModel.type = "staff";
                        //       else
                        //         loginRequestModel.type = "owner";
                        //     },
                        //   ),
                        //   initialIndex: 0,
                        // ),
                        SizedBox(height: 20),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => {
                            loginRequestModel.phonenumber = input.toString(),
                            print(input)
                          },
                          validator: (input) =>
                              input.contains(' ') || input.length == 0
                                  ? "S??? ??i???n tho???i ph???i h???p l???"
                                  : null,
                          decoration: new InputDecoration(
                            hintText: "S??? ??i???n tho???i",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => {
                            loginRequestModel.username = input.toString(),
                            print(input)
                          },
                          validator: (input) =>
                              input.contains(' ') || input.length == 0
                                  ? "T??i kho???n ????ng nh???p ph???i h???p l???"
                                  : null,
                          decoration: new InputDecoration(
                            hintText: "T??i Kho???n ????ng nh???p",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => {
                            loginRequestModel.password = input.toString(),
                            print(input)
                          },
                          validator: (input) =>
                              input.contains(' ') || input.length == 0
                                  ? "M???t kh???u ????ng nh???p ph???i h???p l???"
                                  : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "M???t kh???u ????ng nh???p",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () {
                            if (validateAndSave()) {
                              print(loginRequestModel.toJson());

                              setState(() {
                                isApiCallProcess = true;
                              });

                              APIService apiService = new APIService();
                              apiService.login(loginRequestModel).then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  if (value.token.isNotEmpty) {
                                    write(value.token, value.user);
                                    final snackBar = SnackBar(
                                        content: Text("????ng nh???p th??nh c??ng"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NavigationHomeScreen()),
                                    );
                                  } else {
                                    final snackBar = SnackBar(
                                        content: Text(value.error.isNotEmpty
                                            ? value.error
                                            : "???? x???y ra l???i vui l??ng th??? l???i"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                }
                              }).catchError((onError) {
                                print(onError);
                              });
                            }
                          },
                          child: Text(
                            "????ng nh???p",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
