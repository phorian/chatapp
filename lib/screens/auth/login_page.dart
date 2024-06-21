import 'dart:convert';

import 'package:chat_app/global/my_button.dart';
import 'package:chat_app/global/textfield.dart';
import 'package:chat_app/screens/chat/chat_home_page.dart';
import 'package:chat_app/screens/chat/userprofile.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/configs/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {

  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //username and password controller
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _pwdController = TextEditingController();

  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }


  //login method
  void loginUser() async{
    //login
    if(_usernameController.text.isNotEmpty && _pwdController.text.isNotEmpty){
      final regBody = { 
        "username":_usernameController.text, 
        "password":_pwdController.text
      };
      final response = await http.post(Uri.parse(login),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody));

      //print(response.body);

      //final jsonResponse = jsonDecode(response.body);

      if(response.statusCode == 201){
        var myToken = jsonDecode(response.body)['accessToken'];
        prefs.setString('accessToken', myToken);
        if (!mounted) return;
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(token: myToken)));
      } else{
         print('Error fetching data: ${response.statusCode}');
      }

    }else {
       setState(() {
        _isNotValidate = true;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
          
          
            // welcome back message
            Text(
              "Hello friend, welcome back",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
          
            const SizedBox(height: 25),
          
          
            //username text field
            MyTextField(
              hintText: "Username",
              errorText: _isNotValidate ? "Enter Valid username" : null,
              obscureText: false,
              controller: _usernameController,
            ),
          
            const SizedBox(height: 10),
          
            //password textfield
             MyTextField(
              hintText: "Password",
              errorText: _isNotValidate ? "Enter Valid Password" : null,
              obscureText: true,
              controller: _pwdController,
             ),
          
             const SizedBox(height: 25),
          
            //login button
            MyButton(
              text: "Login",
              onTap: loginUser,
            ),
          
            const SizedBox(height: 15),
          
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                ),),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Register now", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary
                    ),
                    ),
                )
              ],
            ),
          ],
                ),
        ),
      )
    );
  }
}