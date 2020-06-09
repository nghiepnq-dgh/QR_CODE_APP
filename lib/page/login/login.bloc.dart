import 'package:flutter/cupertino.dart';
import 'package:qr_code_app/page/home/HomePage.dart';
import 'package:qr_code_app/page/login/login.model.dart';
import 'package:qr_code_app/page/login/login.repository.dart';
import 'package:qr_code_app/page/user/model/user_me.dart';
import 'package:qr_code_app/page/user/user.repository.dart';
import 'package:qr_code_app/util/LocalStored.dart';
import 'package:qr_code_app/util/toast.message.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final LoginRepository _loginRepository = LoginRepository();
  final UserRepository _userRepository = UserRepository();
  final BehaviorSubject<LoginResponse> _subject =
  BehaviorSubject<LoginResponse>();
  final BehaviorSubject<UserMeResponse> _subjectUserMe =
  BehaviorSubject<UserMeResponse>();

  //TODO Create text fields
  TextEditingController cmnd = new TextEditingController();
  TextEditingController passWord = new TextEditingController();

  //TODO Func Login
  login(identity, password, context) async {
    LoginResponse loginResponse =
        await _loginRepository.loginRepository(identity, password);
    if (loginResponse != null && loginResponse?.success != null) {
      //TODO Save token
      LocalStore.saveToken(loginResponse.acccessToken.toString());

      //TODO save user local
      UserMeResponse userMeResponse = await _userRepository.getMeRepository();
      if (userMeResponse != null) {
        print(userMeResponse.toJson().toString());
        LocalStore.saveUserInfor(userMeResponse.toJson().toString());
      }
      ToastMessage.success(message: "Đăng nhập thành công!");
      _subjectUserMe.sink.add(userMeResponse);
      Navigator.of(context).pushNamed("/");
    } else {
      ToastMessage.error(message: loginResponse?.message);
    }
  }

  dispose() {
    _subject.close();
    _subjectUserMe.close();
  }

  BehaviorSubject<LoginResponse> get subject => _subject;
  BehaviorSubject<UserMeResponse> get subjectUserMe => _subjectUserMe;

}

final blocLoginModule = LoginBloc();
