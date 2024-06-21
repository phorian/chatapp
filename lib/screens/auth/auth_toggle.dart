import 'package:chat_app/screens/auth/login_page.dart';
import 'package:chat_app/screens/auth/register_page.dart';
import 'package:flutter/material.dart';

class AuthToggle extends StatefulWidget {
  const AuthToggle({super.key});

  @override
  State<AuthToggle> createState() => _AuthToggleState();
}

class _AuthToggleState extends State<AuthToggle> {

  //Initial page: Login 
  bool showLoginPage = true;

  //toggle between login and register 
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    if(showLoginPage) {
      return LoginPage(
        onTap: togglePages
      );
    } else {
      return RegisterPage(
        onTap: togglePages
      );
    }
  }
}

