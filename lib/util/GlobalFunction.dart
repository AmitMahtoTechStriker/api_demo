import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_form/callback.dart';
import 'package:login_form/models/login_model.dart';
import 'package:login_form/util/constants.dart';
import 'package:http/http.dart' as http;

class GlobalFunction {
  // Form field state validate
  static bool isValidate(GlobalKey<FormState> formKey) {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // progressing loader
  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Please Wait...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // login api function
  // static Future<String> postData(BuildContext context, String endUrl,
  //     String apiName, Map jsonBody, CallBackInterface callBackInterface) async {
  //   print(jsonBody.toString());
  //   var url = Constant.baseUrl + endUrl;
  //   var response = await http.post(Uri.parse(url),
  //       headers: {
  //         "Accept": "application/json",
  //         "Authorization": 'Bearer ' + "",
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(jsonBody));
  //   print(response.body);
  //
  //   if (response.statusCode == 201 ||response.statusCode == 200) {
  //     callBackInterface.widgetCallBack(apiName, response.body,context);
  //   } else if (response.statusCode == 404) {
  //     if (json.decode(response.body)["message"] != null) {
  //       print("message => "+json.decode(response.body)["message"].toString());
  //     } else {
  //       print("errors =>"+json.decode(response.body)["errors"].toString());
  //     }
  //   }
  //
  //   return "Success!";
  // }



  static Future<String> postData(BuildContext context, String endUrl,
      String apiName, Map jsonBody, CallBackInterface callBackInterface) async {
    print(jsonBody.toString());
    var url = Constant.baseUrl + endUrl;
    var response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer ' + "",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonBody));
    print(response.body);

    if (response.statusCode == 201 ||response.statusCode == 200) {
      callBackInterface.widgetCallBack(apiName, response.body,context);
    } else if (response.statusCode == 404) {
      if (json.decode(response.body)["message"] != null) {
        print("message => "+json.decode(response.body)["message"].toString());
      } else {
        print("errors =>"+json.decode(response.body)["errors"].toString());
      }
    }

    return "Success!";
  }
}
