import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FunctionsUtil {
  static convertStatus(status) {
    switch (status) {
      case "NEW":
        return "Mới";
        break;
      case "APPROVED":
        return "Chấp thuận";
        break;
      case "REJECTED":
        return "Đã từ chối";
        break;
      default:
        return "Mới";
    }
  }
}
