//import 'package:chat_app/global/textfield.dart';
//import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:chat_app/configs/config.dart';
import 'package:http/http.dart' as http;

class Friend {
  final String id;
  final String username;

  Friend({required this.id, required this.username});
}

class UserProfile extends StatefulWidget {
  final String token;
  const UserProfile({super.key, required this.token});

  @override
  State<UserProfile> createState() => _UserProfileState();
}


class _UserProfileState extends State<UserProfile> {
  final TextEditingController _friendUsernameController = TextEditingController();

   late String username;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken =JwtDecoder.decode(widget.token);

    username = jwtDecodedToken['username'];
  }


  void search(){
    print('Search icon was clicked');
  }
  
  Future<void> addContact(String friendUsername) async {
    try{
      final response = await http.post(
        Uri.parse(addFriend),
        body: {
          'friendId': friendUsername
        },
      );
      if(response.statusCode == 200) {
        print('Friend added succesfully');
      } else {
        print('Error adding friend: ${response.body}');
      }
    }
    catch(e) {
      print('Error: $e');
    }
  }

   void showAddContactDialog(BuildContext context) {
     showModalBottomSheet<void>(
       context: context,
       builder: (BuildContext context) {
         return Container(
           padding: EdgeInsets.all(16.0),
           decoration: BoxDecoration(
             color: Theme.of(context).colorScheme.secondary,
           ),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               const Text('Add Contact', style: TextStyle(fontSize: 18.0)),
               SizedBox(height: 16.0),
               TextField(
                 controller: _friendUsernameController,
                 decoration: InputDecoration(
                     contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                     fillColor: Theme.of(context).colorScheme.secondary,
                     hintText: 'Search...',
                     hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                     enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                         borderRadius: BorderRadius.horizontal(
                             left: Radius.circular(10)
                         )
                     ),
                     focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                         borderRadius: BorderRadius.horizontal(
                             left: Radius.circular(10)
                         )
                     )
                 ),
               ),
               SizedBox(height: 16.0),
               ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white60
                 ),
                 onPressed: () {
                   // Handle adding contact logic
                   final friendUsername = _friendUsernameController.text;
                   addContact(friendUsername);
                   Navigator.pop(context); // Close the dialog
                 },
                 child: Text('Add', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
               ),
             ],
           ),
         );
       },
     );
   }


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 75.0, 5.0, 0),
          child: Column(
            children: [
              Row(
                children: [
                   const CircleAvatar(
                    backgroundImage: AssetImage('assets/padreprof.jpg'),
                    radius: 35.0,
                   ),
                   const SizedBox(width: 15.0),
                   Text(
                     username,
                      style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontFamily: 'Roboto',
                  ),
                   )
                ],
              ),

              const SizedBox(height: 10.0),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10)
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            fillColor: Theme.of(context).colorScheme.secondary,
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10)
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10)
                                )
                            )
                        ),
                      ),
                    ),
                  ),

                    Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary
                    ),
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(10)
                    ),
                  color: Colors.grey.shade300,
                  ),
                      child: GestureDetector(
                          onTap: search,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Icon(Icons.search),
                          )
                        ),
                    ),

                      const SizedBox(width: 10.0),
                  Container(
                   // margin: EdgeInsets.,
                    height: 40.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary
                      ),
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.shade300,
                    ),
                    child: GestureDetector(
                        onTap:() {
                           showAddContactDialog(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Icon(Icons.add),
                        )
                    ),
                  ),


                ],
              )
            ],
          ),
          );


  }
}

