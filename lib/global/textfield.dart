import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextEditingController? controller;
  const MyTextField({
      super.key,
      this.hintText,
    required  this.obscureText,
      this.controller,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          )
        ),
      ),
    );
  }
}