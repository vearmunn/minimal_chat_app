// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// import 'package:minimal_chat_app/utils/spacer.dart';
// import 'package:minimal_chat_app/widgets/custom_button.dart';
// import 'package:minimal_chat_app/widgets/custom_textfield.dart';

// import '../../../utils/get_colors.dart';
// import '../controllers/auth_service.dart';

// class RegisterPage extends StatelessWidget {
//   final VoidCallback onTap;
//   RegisterPage({super.key, required this.onTap});

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _cpasswordController = TextEditingController();

//   void register(context) async {
//     final authService = AuthService();

//     if (_passwordController.text == _cpasswordController.text) {
//       try {
//         await authService.signUp(
//           _emailController.text,
//           _passwordController.text,
//         );
//       } catch (e) {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(title: Text(e.toString())),
//         );
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(title: Text("Password don't match!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: getSurface(context),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // logo
//             Icon(Icons.message, size: 60, color: getPrimary(context)),
//             verticalSpacer(30),

//             // welcome back message
//             Text(
//               "Let's make an account for you!",
//               style: TextStyle(color: getPrimary(context), fontSize: 16),
//             ),
//             verticalSpacer(20),

//             // email textfield
//             CustomTextfield(
//               hintText: 'Email',
//               obscure: false,
//               controller: _emailController,
//             ),

//             verticalSpacer(10),

//             // password textfield
//             CustomTextfield(
//               hintText: 'Password',
//               obscure: true,
//               controller: _passwordController,
//             ),
//             verticalSpacer(10),

//             // password textfield
//             CustomTextfield(
//               hintText: 'Confirm Password',
//               obscure: true,
//               controller: _cpasswordController,
//             ),

//             verticalSpacer(20),

//             // login button
//             CustomButton(text: 'Register', onTap: () => register(context)),
//             verticalSpacer(20),

//             // register button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Already have an account? ',
//                   style: TextStyle(color: getPrimary(context)),
//                 ),
//                 GestureDetector(
//                   onTap: onTap,
//                   child: Text(
//                     'Login now',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: getPrimary(context),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
