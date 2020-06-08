import 'package:flutter/cupertino.dart';
import 'package:qr_code_app/page/login/login.model.dart';
import 'package:qr_code_app/page/login/login.repository.dart';
import 'package:qr_code_app/util/toast.message.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final LoginRepository _loginRepository = LoginRepository();
  final BehaviorSubject<LoginResponse> _subject =
      BehaviorSubject<LoginResponse>();

  TextEditingController cmnd = new TextEditingController();
  TextEditingController passWord = new TextEditingController();

  login(identity, password) async {
    LoginResponse loginResponse =
        await _loginRepository.loginRepository(identity, password);
    if (loginResponse != null && loginResponse?.success != null) {
      ToastMessage.success(message: loginResponse?.success);
    } else {
      ToastMessage.error(message: loginResponse?.message);
    }
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<LoginResponse> get subject => _subject;
}

final blocLoginModule = LoginBloc();
