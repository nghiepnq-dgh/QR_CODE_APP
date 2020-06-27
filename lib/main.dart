import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:qr_code_app/SplashScreen.dart';
import 'package:qr_code_app/util/LocalStored.dart';

void main() {
  runApp(LoadingProvider(
      themeData: LoadingThemeData(
        tapDismiss: true,
      ),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalStore.getInstance();
    return MaterialApp(
      title: 'QR CODE',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenPgae(),
    );
  }
}
