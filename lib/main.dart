import 'package:chat_app/global/light_mode_theme.dart';
import 'package:chat_app/screens/auth/auth_toggle.dart';
import 'package:chat_app/screens/chat/chat_home_page.dart';
//import 'package:chat_app/screens/auth/login_page.dart';
//import 'package:chat_app/screens/chat/chat_home_page.dart';
import 'package:chat_app/screens/chat/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:http/http.dart' as http;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs= await SharedPreferences.getInstance();
  final String? token = prefs.getString('accessToken');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {

  final String? token;
  const MyApp({super.key, @required this.token});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = token != null && !JwtDecoder.isExpired(token!);
    return MaterialApp(
      home: isLoggedIn?ChatHomePage(token: token): const AuthToggle(),
      //home:const AuthToggle(),
      theme: lightMode,
    );
  }
}