import 'package:chat_app/global/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserProfile extends StatefulWidget {
  final token;
  const UserProfile({super.key, this.token});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

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
  
  void addContact(){
    print('Add icon was clicked');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                        onTap: search,
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
          ),
    );
  }
}