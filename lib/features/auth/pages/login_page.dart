// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_chat_app/features/auth/controllers/bloc/auth_bloc.dart';

import 'package:minimal_chat_app/utils/spacer.dart';

import '../../../utils/get_colors.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimary(context),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpacer(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.message, size: 30, color: getOnPrimary(context)),
                  horizontalSpacer(4),
                  Text(
                    'Mini Chat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: getOnPrimary(context),
                    ),
                  ),
                ],
              ),
              verticalSpacer(20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/images/login_image.jpg'),
              ),

              verticalSpacer(30),
              Text(
                "Real Talk Starts Here",
                style: TextStyle(
                  color: getOnPrimary(context),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpacer(4),
              Text(
                "A fun, easy way to keep the conversation going with your favorite people.",
                textAlign: TextAlign.center,
                style: TextStyle(color: getOnPrimary(context), fontSize: 12),
              ),
              verticalSpacer(30),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailed) {
                    showDialog(
                      context: context,
                      builder:
                          (context) =>
                              AlertDialog(title: Text(state.errorMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator(
                      color: getOnPrimary(context),
                    );
                  }
                  return ElevatedButton.icon(
                    onPressed:
                        () => context.read<AuthBloc>().add(SignInWithGoogle()),
                    icon: Image.asset('assets/images/google.png', height: 28),
                    label: Text(
                      'Sign In with Google',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  // final authService = AuthService();
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

  // void loginWithGoogle(context) async {
  //   try {
  //     await authService.signInWithGoogle();
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(title: Text(e.toString())),
  //     );
  //   }
  // }

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