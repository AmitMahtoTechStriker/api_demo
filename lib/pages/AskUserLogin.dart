import 'package:flutter/material.dart';
import 'package:login_form/callback.dart';

import '../widgets.dart';

class AskUserLogin extends StatefulWidget {
  const AskUserLogin({Key? key}) : super(key: key);

  @override
  State<AskUserLogin> createState() => _AskUserLoginState();
}

class _AskUserLoginState extends State<AskUserLogin> implements CallBackInterface{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              label("To use this feature you have to login the application."),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void widgetCallBack(String title, String value, BuildContext context) {
    // TODO: implement widgetCallBack
  }
}
