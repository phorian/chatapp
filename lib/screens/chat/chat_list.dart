import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/configs/config.dart';

class Friend {
  final String id;
  final String username;
  final String avi;

  Friend({required this.id, required this.username, required this.avi});
}

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late Future<List<Friend>> _friends;
  @override
  void initState(){
    super.initState();
    _friends = fetchFriends();
  }

  Future<List<Friend>> fetchFriends() async {
    final response = await http.get(Uri.parse(friendList));
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['friends'] as List)
          .map((friendData) => Friend(
        id: friendData['_id'],
        username: friendData['username'],
        avi: friendData['avi'],
      )).toList();
    } else {

      throw Exception('failed to load friends');
    }
  }
  Widget build(BuildContext context) {

    return FutureBuilder<List<Friend>>(
        future: _friends,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();

          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final friends = snapshot.data!;
            return ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(friends[index].avi),
                    ),
                    title: Text(friends[index].username),
                  );
                },
            );
          }
        },
    );
  }
}
