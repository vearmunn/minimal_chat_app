// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/get_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.obscure,
    required this.controller,
    this.focusNode,
  });

  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: getTertiary(context)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: getPrimary(context)),
          ),
          fillColor: getSecondary(context),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: getPrimary(context)),
        ),
      ),
    );
  }
}
