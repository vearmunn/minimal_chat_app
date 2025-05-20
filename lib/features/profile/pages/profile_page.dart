import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_chat_app/features/auth/controllers/bloc/auth_bloc.dart';
import 'package:minimal_chat_app/features/chat/controllers/chat_service.dart';
import 'package:minimal_chat_app/themes/bloc/theme_bloc.dart';

import '../controllers/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ChatService chatService = ChatService();
  @override
  void initState() {
    context.read<ProfileBloc>().add(
      FetchCurrentUserProfile(chatService.getCurrentUser()!.uid),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: isDark,
            onChanged: (v) {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileFailed) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  Text(state.userProfile['uid']),
                  Text(state.userProfile['email']),
                  Text(state.userProfile['name']),
                  ElevatedButton(
                    onPressed: () => context.read<AuthBloc>().add(SignOut()),
                    child: Text('Logout'),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
