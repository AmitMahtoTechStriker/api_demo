import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_form/callback.dart';
import 'package:login_form/models/login_model.dart';
import 'package:login_form/pages/register.dart';
import 'package:login_form/util/GlobalFunction.dart';
import 'package:login_form/util/constants.dart';
import 'package:login_form/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements CallBackInterface {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password =TextEditingController();
  late LoginModel loginModel;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      autofocus: false,
      controller: _email,
      decoration: buildInputDecoration("Enter your email", Icons.email),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email';
        }
        if (!EmailValidator.validate(value.toString())) {
          return 'Please enter valid email address';
        }
        return null;
      },
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final passwordFieldEye = TextFormField(
      autofocus: false,
      obscureText: _isObscure,
      controller: _password,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      decoration: buildInputDecorationForPass(
          "Enter your password", Icons.lock, _isObscure, this,context),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: const Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {},
        ),
        TextButton(
          child: const Text("Sign up",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) =>Register()));
          },
        ),
      ],
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo('assets/images/user2.png',"1"),
                  const SizedBox(height: 20.0),
                  label("Email"),
                  const SizedBox(height: 5.0),
                  usernameField,
                  const SizedBox(height: 20.0),
                  label("Password"),
                  const SizedBox(height: 5.0),
                  passwordFieldEye,
                  const SizedBox(height: 20.0),
                  longButtons("Login", this,context),
                  const SizedBox(height: 5.0),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void widgetCallBack(String title,String value,BuildContext context) {
    switch (title) {
      case "hint":
        {
          setState(() {

          });
          if (_isObscure) {
            _isObscure = false;
          } else {
            _isObscure = true;
          }
          break;
        }
      case "loginApi":
        {
          if (GlobalFunction.isValidate(_formKey)) {
            GlobalFunction.showLoaderDialog(context);
              print("email =>"+_email.text);
              print("password =>"+_password.text);

            var  jsonBody  =  {
              "email":_email.text.toString().trimRight(),
              "password": _password.text.toString().trimRight(),
              "device_token":Constant.deviceToken
            };
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            GlobalFunction.postData(context,Constant.login,"LoginDone",jsonBody,this);
          }
          break;
        }

      case "LoginDone":{
        Navigator.pop(context);
        // print("Data =>"+value);
        loginModel=LoginModel.fromJson(jsonDecode(value));
        print("Data =>"+loginModel.user!.userType.toString());
        print("loginModel =>"+loginModel.toJson().toString());
        break;
      }
    }
  }
}
