import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/BPage.dart';
import 'package:login/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutTube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // 去除右上方Debug標誌
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  String account = "";
  String password = "";

  final GlobalKey<FormFieldState> _accountKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登入測試練習'),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Container(
                  child: textFormField(
                      _accountKey, Icon(Icons.person), '請輸入帳號', '帳號至少5個字元')),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: textFormField(
                      _passwordKey, Icon(Icons.vpn_key), '請輸入密碼', '密碼至少5個字元')),
              SizedBox(
                height: 52,
              ),
              Row(
                children: [
                  Expanded(
                      child: RaisedButton(
                    child: Text('登入'),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode()); // 隱藏鍵盤
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
                      if (_accountKey.currentState.validate() &&
                          _passwordKey.currentState.validate()) {
                        if (account == "12345" && password == "12345") {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  Text('登入成功')
                                ],
                              ),
                            ),
                          );
                          Future.delayed(Duration(seconds: 2),(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
                          });
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Row(
                                children: [
                                  Icon(Icons.close),
                                  Text('帳號或密碼錯誤'),
                                ],
                              )));
                        }
                      }
                    },
                  )),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: RaisedButton(
                    child: Text('註冊'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegistPage()));
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ///  帳號 和 密碼的 Widget
  TextFormField textFormField(GlobalKey<FormFieldState> key, Icon icon,
      String hint, String validatorText) {
    return TextFormField(
      key: key,
      inputFormatters: [
        // 限制最長 10 字元
        LengthLimitingTextInputFormatter(10),
        // 限制英文、數字
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9]"))
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(prefixIcon: icon, hintText: hint),
      validator: (value) {
        // 若小於 5 個字元，給予提示
        if (value.length < 5) {
          return validatorText;
        }

        if (key == _accountKey) {
          account = value;
        }

        if (key == _passwordKey) {
          password = value;
        }

        return null;
      },
    );
  }
}
