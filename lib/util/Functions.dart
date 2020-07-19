class FunctionsUtil {
  static convertStatus(status) {
    switch (status) {
      case "NEW":
        return "Chờ xử lí";
        break;
      case "APPROVED":
        return "Hoàn tất";
        break;
      case "WAITTING":
        return "Đang xử lí";
        break;
      case "ADDINNFO":
        return "Thêm thông tin";
        break;
      case "REJECTED":
        return "Đã từ chối";
        break;
      default:
        return "Chờ xử lí";
    }
  }
}
