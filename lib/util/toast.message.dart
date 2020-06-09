import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static success({message}) {
    Fluttertoast.showToast(
        msg: message != null ? message : "Thành công",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightBlue[200],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static error({message}) {
    Fluttertoast.showToast(
        msg: message ?? "Có lỗi xảy ra vui lòng thử lại sau ít phút!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
