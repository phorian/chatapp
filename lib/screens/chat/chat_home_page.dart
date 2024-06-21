//import 'package:chat_app/global/textfield.dart';
import 'package:chat_app/screens/chat/chat_list.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:chat_app/screens/chat/userprofile.dart';
//import 'package:chat_app/screens/chat/chat_list.dart';


class ChatHomePage extends StatefulWidget {
  final token;
  final void Function()? onTap;
  const ChatHomePage({super.key, this.token, this.onTap});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:
        const SafeArea(
          child: Column(
                  children: [
                    UserProfile(),
                    //Expanded(child: ChatList())
                    //ChatList()
                  ],
                ),
        ),
    );
  }
}