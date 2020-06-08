import 'package:flutter/material.dart';
import 'package:qr_code_app/page/login/login.bloc.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
              colors: [Colors.lightBlue, Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Đăng nhập 📱", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextField(
                    controller: blocLoginModule.cmnd,
                    autofocus: true,
                    cursorColor: Colors.amber,
                    cursorWidth: 2.0,
                    style: TextStyle(height: 1.0),
                    decoration: InputDecoration(
                      hintText: "CMND",
                      prefixIcon: Icon(Icons.supervised_user_circle),
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
                    controller: blocLoginModule.passWord,
                    autofocus: true,
                    style: TextStyle(height: 1.0),
                    cursorColor: Colors.amber,
                    cursorWidth: 2.0,
                    decoration: InputDecoration(
                      hintText: "Mật khẩu",
                      prefixIcon: Icon(Icons.lock),
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
                  MaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Đăng nhập'),
                    ),
                    color: Colors.amber,
                    textColor: Colors.white,
                    splashColor: Colors.redAccent,
                    minWidth: 150,
                    onPressed: () async {
                        print(blocLoginModule.cmnd.text);
                        print(blocLoginModule.passWord.text);
                        await blocLoginModule.login(blocLoginModule.cmnd.text, blocLoginModule.passWord.text);
                    },
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
