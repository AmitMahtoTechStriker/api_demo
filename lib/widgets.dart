import 'package:flutter/material.dart';
import 'package:login_form/callback.dart';
import 'package:login_form/providers/user_provider.dart';
import 'package:provider/provider.dart';

MaterialButton longButtons(String title,CallBackInterface callBackInterface,BuildContext context,
    {Color color: const Color(0xfff063057), Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: () {
      callBackInterface.widgetCallBack("loginApi","",context);
    },
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

InputDecoration buildInputDecorationForPass(String hintText, IconData icon, bool _isObscure,CallBackInterface callBackInterface,BuildContext context) {
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    suffixIcon: IconButton(
      icon: Icon(
        _isObscure ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        callBackInterface.widgetCallBack("hint","",context);
      },
    ),
  );
}

Center image(){
  return const Center(
    child: Image(
      image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
      height: 100,
      width: 100,
    ),
  );
}
Center logo(String imagePath,String type){
  return Center(
    child: Column(
      children: [
        Image.asset(imagePath,height: 130,),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Text(type=="1"?"Login":"Register",style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
        )
      ],
    ),
  );
}
