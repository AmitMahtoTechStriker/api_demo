import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_form/callback.dart';
import 'package:login_form/models/login_model.dart';
import 'package:login_form/providers/auth.dart';
import 'package:login_form/providers/user_provider.dart';
import 'package:login_form/util/GlobalFunction.dart';
import 'package:login_form/util/constants.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> implements CallBackInterface{
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password =TextEditingController();
  late LoginModel loginModel;
  late AuthProvider auth;
  late UserProvider? userProvider=null;

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
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
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: const Text("Have already account?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {},
        ),
        TextButton(
          child: const Text("Login",
              style: TextStyle(fontWeight: FontWeight.w300,color: Colors.green)),
          onPressed: () {
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
                  logo('assets/images/user2.png',"2"),
                  const SizedBox(height: 20.0),
                  label("Email"),
                  const SizedBox(height: 5.0),
                  usernameField,
                  const SizedBox(height: 20.0),
                  label("Password"),
                  const SizedBox(height: 5.0),
                  passwordFieldEye,
                  const SizedBox(height: 20.0),
                  longButtons("Register", this,context),
                  const SizedBox(height: 5.0),
                  userProvider!=null && userProvider!.user.user!=null ?Text(userProvider!.user.user!.email.toString()):Text("jkbasf")
                  // userProvider!=null?Text(userProvider!.user.user!.email.toString()):Text("lknkjbdf")
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

          if (GlobalFunction.isValidate(_formKey)) {
            GlobalFunction.showLoaderDialog(context);
            print("email =>"+_email.text);
            print("password =>"+_password.text);

            var  jsonBody  =  {
              "email":_email.text.toString().trimRight(),
              "password": _password.text.toString().trimRight(),
              "device_token":Constant.deviceToken
            };
            final Future<LoginModel> successfulMessage =
            auth.login(jsonBody);
            successfulMessage.then((response){
              userProvider!.setUser(response);
              print("message"+response.message.toString());
            });
          }
          break;


      case "LoginDone":{
        // Navigator.pop(context);
        // // print("Data =>"+value);
        // loginModel=LoginModel.fromJson(jsonDecode(value));
        // print("Data =>"+loginModel.user!.userType.toString());
        // print("loginModel =>"+loginModel.toJson().toString());
        break;
      }
    }
  }
}
