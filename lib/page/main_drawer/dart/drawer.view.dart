import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/util/ImgPath.dart';
import 'package:qr_code_app/util/LocalStored.dart';

class ListMenuProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>.value(
      value: getUerMe(),
      child: ListMenuItem(),
    );
  }

  Future<String> getUerMe() async {
    final user = await LocalStore.getUserInfor();
    if (user != null) return user;
    return "empty";
  }
}

class ListMenuItem extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<String>(
      builder: (context, value, child) {
        //TODO LOGIN
        if (value != "empty") {
          final userInfo = json.decode(value);
          final email = userInfo['email'];
          final role = userInfo['role'];
          final identity = userInfo['identity'];
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 30.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(ImgPath.logo),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          identity,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(email,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(role == "NORMAL" ? "" : "Người đánh giá",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text(
                    "Danh sách hồ sơ",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/document");
                  },
                ),
                role == "NORMAL" ? ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    "Lịch sử tìm kiếm",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/history");
                  },
                ) : SizedBox(),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text(
                    "Đổi mật khẩu",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/change-pass");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text(
                    "Đăng xuất",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    LocalStore.saveToken("");
                    LocalStore.saveUserInfor("empty");
                    Navigator.of(context).pushNamed("/splash");
                  },
                ),
              ],
            ),
          );
        }
        //TODO NO LOGIN
        return Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Colors.lightBlueAccent,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 30.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(ImgPath.logo), fit: BoxFit.fill),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text(
                "Đăng nhập",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/login");
              },
            ),
          ],
        );
      },
    );
  }
}
