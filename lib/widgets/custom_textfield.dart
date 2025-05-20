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
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        focusNode: focusNode,
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: getSecondary(context)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: getPrimary(context)),
          ),
          fillColor: getTertiary(context),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: getOnTertiary(context).withAlpha(100)),
        ),
      ),
    );
  }
}
