// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/features/auth/controllers/auth_service.dart';

import 'package:minimal_chat_app/utils/spacer.dart';

import '../../../utils/get_colors.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onTap;

  LoginPage({super.key, required this.onTap});

  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  final authService = AuthService();
  // void login(context) async {
  //   try {
  //     await authService.signIn(_emailController.text, _passwordController.text);
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(title: Text(e.toString())),
  //     );
  //   }
  // }

  void loginWithGoogle(context) async {
    try {
      await authService.signInWithGoogle();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getSurface(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(Icons.message, size: 60, color: getPrimary(context)),
            verticalSpacer(30),

            // welcome back message
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(color: getPrimary(context), fontSize: 16),
            ),
            verticalSpacer(20),

            // // email textfield
            // CustomTextfield(
            //   hintText: 'Email',
            //   obscure: false,
            //   controller: _emailController,
            // ),

            // verticalSpacer(10),

            // // password textfield
            // CustomTextfield(
            //   hintText: 'Password',
            //   obscure: true,
            //   controller: _passwordController,
            // ),

            // verticalSpacer(20),

            // // login button
            // CustomButton(text: 'Login', onTap: () => login(context)),
            // verticalSpacer(20),

            // // register button
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Not a member?  ',
            //       style: TextStyle(color: getPrimary(context)),
            //     ),
            //     GestureDetector(
            //       onTap: onTap,
            //       child: Text(
            //         'Register now',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: getPrimary(context),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // verticalSpacer(20),
            ElevatedButton(
              onPressed: () => loginWithGoogle(context),
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
