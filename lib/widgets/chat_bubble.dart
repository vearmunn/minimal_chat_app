// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/get_colors.dart';
import '../utils/spacer.dart';

class ChatBubble extends StatelessWidget {
  final bool isCurrentUser;
  final String text;
  final String time;
  const ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // Column at the top to prevent the container from fully stretching
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: EdgeInsets.fromLTRB(
                12,
                12,
                text.length > 40 ? 20 : 50,
                12,
              ),
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.green : getTertiary(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(
                time,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      isCurrentUser
                          ? getSecondary(context)
                          : getPrimary(context),
                ),
              ),
            ),
          ],
        ),
        verticalSpacer(12),
      ],
    );
  }
}
