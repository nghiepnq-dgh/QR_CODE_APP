import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/SplashScreen.dart';
import 'package:qr_code_app/page/document/document.bloc.dart';
import 'package:qr_code_app/page/document/view/document.view.dart';
import 'package:qr_code_app/page/history/history.bloc.dart';
import 'package:qr_code_app/page/history/view/list-history.view.demo.dart';
import 'package:qr_code_app/page/home/HomePage.dart';
import 'package:qr_code_app/page/login/login.view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomePage());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginView());
      case "/splash":
        return MaterialPageRoute(builder: (_) => SplashScreenPgae());
      case "/document":
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return ChangeNotifierProvider<DocumentBloc>(
                create: (_) => DocumentBloc(),
                child: DocumentPage(),
              );
            });
      case "/history":
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return ChangeNotifierProvider<HistoryBloc>(
                create: (_) => HistoryBloc(),
                child: PageListHistoryDemo(),
              );
            });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Page not found!"),
        ),
      );
    });
  }
}
