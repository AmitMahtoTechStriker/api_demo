import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login_form/models/login_model.dart';
import 'package:login_form/util/constants.dart';


enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;


  Future<LoginModel> login(Map loginData) async {
    var url = Constant.baseUrl + Constant.login;
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var response = await post(
      Uri.parse(url),
      body: json.encode(loginData),
      headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ' + "",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = json.decode(response.body);
      LoginModel authUser = LoginModel.fromJson(responseData);
      print(authUser.user!.email.toString());
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      if (json.decode(response.body)["message"] != null) {
        print("message => "+json.decode(response.body)["message"].toString());
      } else {
        print("errors =>"+json.decode(response.body)["errors"].toString());
      }

    }
    return LoginModel.fromJson(json.decode(response.body));
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }

}