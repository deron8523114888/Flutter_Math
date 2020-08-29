import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Regist();
  }
}

class Regist extends State<RegistPage > {
  String account;

  String password;

  String name;

  String school = '請選擇學校';

  final GlobalKey<FormFieldState> accountKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> schoolKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();

  List<String> schoolList = ['請選擇學校', '建國中學', '北一女中', '高雄中學', '高雄女中'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('註冊'),
      ),
      body: Builder(
          builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Container(
                        child: textFormField(accountKey, Icon(Icons.person),
                            '請輸入帳號', '帳號至少5個字元，最多10個字元')),
                    Container(
                        margin: EdgeInsets.only(top: 30),
                        child: textFormField(passwordKey, Icon(Icons.vpn_key),
                            '請輸入密碼', '密碼至少5個字元，最多10個字元')),
                    Container(
                        margin: EdgeInsets.only(top: 30, bottom: 30),
                        child: textFormField(
                            nameKey, Icon(Icons.sd_card), '請輸入名稱', '名稱最多3個字元')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(Icons.school, color: Colors.grey)),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: DropdownButton(
                              value: school,
                              items: schoolList
                                  .map((String value) => DropdownMenuItem(
                                      value: value, child: Text(value)))
                                  .toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  school = newValue;
                                  if (schoolList[0] == '請選擇學校') {
                                    schoolList.removeAt(0);
                                  }
                                });
                              },
                            ))
                      ],
                    )
                  ],
                ),
              )),
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
        if (key == accountKey || key == passwordKey) {
          // 若小於 5 個字元，給予提示
          if (value.length < 5) {
            return validatorText;
          }
        }

        if (key == nameKey) {
          if (value.length != 3) {
            return validatorText;
          }
        }

        if (key == schoolKey) {
          if (value == '請選擇學校') {
            return validatorText;
          }
        }

        return null;
      },
    );
  }
}
