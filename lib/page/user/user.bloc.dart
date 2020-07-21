import 'package:flutter/cupertino.dart';
import 'package:qr_code_app/page/user/model/user_me.dart';
import 'package:qr_code_app/page/user/user.repository.dart';
import 'package:qr_code_app/util/toast.message.dart';

class UserBloc {
  final UserRepository _userRepository = UserRepository();

  //TODO Create text fields
  TextEditingController password = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController reNewPassword = new TextEditingController();

  //TODO Func Change Pass
  changePass(password, newPassword, reNewPassword, context) async {
    UserMeResponse userMeResponse =
        await _userRepository.changePass(password, newPassword, reNewPassword);
    if (userMeResponse != null && userMeResponse?.success != null) {
      ToastMessage.success(message: "Đổi mật khẩu thành công!");
      Navigator.of(context).pushNamed("/");
    } else {
      ToastMessage.error(message: userMeResponse?.message);
    }
  }
  dispose() {}
}

final blocUserModule = UserBloc();
