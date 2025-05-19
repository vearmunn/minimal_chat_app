// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/get_colors.dart';
import '../utils/spacer.dart';

class ChatBubble extends StatelessWidget {
  final bool isCurrentUser;
  final String text;
  const ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green : getTertiary(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        ),
        verticalSpacer(12),
      ],
    );
  }
}
