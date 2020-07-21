import 'package:flutter/material.dart';
import 'package:qr_code_app/page/user/user.bloc.dart';
import 'package:qr_code_app/util/toast.message.dart';

class ChangePassPage extends StatefulWidget {
  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.7],
              colors: [Colors.yellow[50], Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "☘️❄️ Đổi Mật Khẩu ❄️☘️",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextField(
                    obscureText: true,
                    controller: blocUserModule.password,
                    autofocus: true,
                    cursorColor: Colors.amber,
                    cursorWidth: 2.0,
                    style: TextStyle(height: 1.0),
                    decoration: InputDecoration(
                      hintText: "Mật khẩu củ",
                      prefixIcon: Icon(Icons.lock_open),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    controller: blocUserModule.newPassword,
                    autofocus: true,
                    style: TextStyle(height: 1.0),
                    cursorColor: Colors.amber,
                    cursorWidth: 2.0,
                    decoration: InputDecoration(
                      hintText: "Mật khẩu mới",
                      prefixIcon: Icon(Icons.new_releases),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    controller: blocUserModule.reNewPassword,
                    autofocus: true,
                    style: TextStyle(height: 1.0),
                    cursorColor: Colors.amber,
                    cursorWidth: 2.0,
                    decoration: InputDecoration(
                      hintText: "Nhập lại mật khẩu mới",
                      prefixIcon: Icon(Icons.new_releases),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Quay lại'),
                        ),
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        splashColor: Colors.redAccent,
                        minWidth: 150,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Đổi mật khẩu'),
                        ),
                        color: Colors.amber,
                        textColor: Colors.white,
                        splashColor: Colors.redAccent,
                        minWidth: 150,
                        onPressed: () async {
                          if (blocUserModule.password.text.isEmpty ||
                              blocUserModule.newPassword.text.isEmpty ||
                              blocUserModule.reNewPassword.text.isEmpty) {
                            ToastMessage.error(
                                message: "Vui lòng nhập đầy đủ thông tin!");
                          } else {
                            await blocUserModule.changePass(
                                blocUserModule.password.text,
                                blocUserModule.newPassword.text,
                                blocUserModule.reNewPassword.text,
                                context);
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
