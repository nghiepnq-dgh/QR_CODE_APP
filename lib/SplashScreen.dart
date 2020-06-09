import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_app/page/home/HomePage.dart';
import 'package:qr_code_app/util/ImgPath.dart';
import 'package:qr_code_app/util/Navigation.dart';

class SplashScreenPgae extends StatefulWidget {
  @override
  _SplashScreenPgaeState createState() => _SplashScreenPgaeState();
}

class _SplashScreenPgaeState extends State<SplashScreenPgae> {
  Size _size;
  Timer _timer;

@override
  void initState() {
    super.initState();
    _timer = new Timer(const Duration(seconds: 3), () {
      NavigatorUtil.pushAndRemoveUntil(context, HomePage());
    });

  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Roboto",
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.7],
              colors: [
//                Color(0xFFF12711),
//                Color(0xFFf5af19),
                Colors.lightBlue,
                Colors.white
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage(ImgPath.logo)),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Phần Mềm Quét QR Code Hồ Sơ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text("Loading..."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
