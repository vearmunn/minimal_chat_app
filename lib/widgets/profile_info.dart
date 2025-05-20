// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/get_colors.dart';
import '../utils/spacer.dart';

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const ProfileInfo({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        horizontalSpacer(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(value, style: TextStyle(color: getSecondary(context))),
          ],
        ),
      ],
    );
  }
}
