import 'package:flutter/material.dart';

import '../../auth/controllers/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: logout, child: Text('Logout')),
      ),
    );
  }
}
