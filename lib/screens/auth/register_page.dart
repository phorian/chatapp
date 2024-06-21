import 'dart:convert';
//import 'dart:html';

import 'package:chat_app/global/my_button.dart';
import 'package:chat_app/global/textfield.dart';
import 'package:chat_app/screens/auth/login_page.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/configs/config.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
   const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    //username and password controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _pwdController = TextEditingController();

  bool _isNotValidate = false;

   //Register method
  void registerUser() async {
    //register
    if(_emailController.text.isNotEmpty && _usernameController.text.isNotEmpty && _pwdController.text.isNotEmpty){
      final regBody = { 
        "email":_emailController.text,
        "username":_usernameController.text, 
        "password":_pwdController.text
      };
      final response = await http.post(Uri.parse(registration),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody));

      //final jsonResponse = jsonDecode(response.body);

      if(response.statusCode == 201){
        if (!mounted) return;
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(onTap: widget.onTap,)));
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
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
          
            const SizedBox(height: 20),
          
          
            //username text field
            MyTextField(
              hintText: "Email",
              errorText: _isNotValidate ? "Enter Valid Email" : null,
              obscureText: false,
              controller: _emailController,
            ),
          
            const SizedBox(height: 10),
          
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
          
            const SizedBox(height: 10),
          
            //login button
            MyButton(
              text: "Register",
              onTap: registerUser
            ),
          
            const SizedBox(height: 15),
          
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                ),),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Log in", 
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
