// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// import '../utils/get_colors.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton({super.key, required this.text, required this.onTap});

//   final String text;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(20),
//         margin: EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           color: getSecondary(context),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               // color: getPrimary(context),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
