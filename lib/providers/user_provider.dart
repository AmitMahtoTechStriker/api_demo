import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:login_form/models/login_model.dart';

class UserProvider with ChangeNotifier {
  LoginModel _user = LoginModel();

  LoginModel get user => _user;

  void setUser(LoginModel user) {
    _user = user;
    notifyListeners();
  }
}
