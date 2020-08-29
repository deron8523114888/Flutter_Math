import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/menu/Perosnal.dart';
import 'package:login/menu/Rank.dart';
import 'package:login/menu/Setting.dart';
import 'package:login/menu/Study.dart';
import 'package:login/menu/Test.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutTube',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false, // 去除右上方Debug標誌
      home: Menu(),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuState();
}

class MenuState extends State<Menu> {
  List chatList = ['**歡迎加入聊天室**'];

  TextEditingController chatController = TextEditingController();

  String hintString = '說點什麼';
  Color hintColor = Colors.grey;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Center(
            child: Text(
              '校門口',
              style: TextStyle(),
            ),
          ),
          actions: [
            Builder(
              builder: (context) => Container(
                margin: EdgeInsets.all(14),
                child: IconButton(
                  icon: Icon(Icons.credit_card),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('儲值功能尚未開啟'),
                        duration: Duration(
                          seconds: 2
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Personal(), // 個人訊息畫面
            Study(), // 課程影片畫面
            Rank(), // 排行榜畫面
            Test(), // 練習、考試選擇畫面
            Setting() // 設定畫面
          ],
        ),

        /// 左側滑開 聊天室畫面
        drawer: Builder(
          builder: (context) => Drawer(
            /// 聊天 View 視窗
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),

                      /// 每一訊息列
                      itemBuilder: (context, index) {
                        if (index != 0) {
                          return Row(
                            children: [
                              Icon(Icons.person),
                              Text(chatList[index]),
                            ],
                          );
                        }
                        return Row(
                          children: [Text(chatList[0])],
                        );
                      },
                      itemCount: chatList.length,
                    ),
                  ),

                  /// 打字視窗 + Button
                  Container(
                    margin: EdgeInsets.only(bottom: 16, left: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              hintText: hintString,
                              hintStyle: TextStyle(
                                color: hintColor,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                              WhitelistingTextInputFormatter(
                                  RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")),
                            ],

                            /// 利用 controller 控制框內訊息
                            controller: chatController,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            setState(() {
                              if (chatController.text.isNotEmpty) {
                                chatList
                                    .add(chatController.text); // 將訊息存入 list 並刷新
                                chatController.clear(); // 清空訊息欄
                                hintString = '說點什麼';
                                hintColor = Colors.grey;
                              } else {
                                hintString = '禁止送出空白訊息';
                                hintColor = Colors.red;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// 下方列表
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Container(
              height: 50,
              child: TabBar(
                tabs: tabList.map((choice) {
                  return Tab(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(choice.icon, color: Colors.grey),
                      Text(
                        choice.title,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ));
                }).toList(),
              ),
            )),
      ),
    );
  }
}

/// tabBar 寫法
class TabChoice {
  final String title;
  final IconData icon;

  const TabChoice(this.title, this.icon);
}

const List<TabChoice> tabList = const <TabChoice>[
  TabChoice('訊息', Icons.person),
  TabChoice('上課', Icons.laptop_chromebook),
  TabChoice('排行榜', Icons.school),
  TabChoice('考試', Icons.book),
  TabChoice('設定', Icons.settings),
];
