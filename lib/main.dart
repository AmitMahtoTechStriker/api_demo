import 'package:flutter/material.dart';
import 'package:login_form/login.dart';
import 'package:login_form/pages/register.dart';
import 'package:login_form/providers/auth.dart';
import 'package:login_form/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        routes: {
          "/":(context) =>Login(),
          "/register":(context) =>Register()
        },
      ),
    );
  }
}
