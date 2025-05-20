import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_chat_app/features/auth/controllers/bloc/auth_bloc.dart';
import 'package:minimal_chat_app/features/chat/controllers/chat_service.dart';
import 'package:minimal_chat_app/themes/bloc/theme_bloc.dart';
import 'package:minimal_chat_app/utils/get_colors.dart';
import 'package:minimal_chat_app/utils/spacer.dart';

import '../../../widgets/profile_info.dart';
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpacer(30),
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person_pin, size: 60),
                    ),
                    verticalSpacer(30),
                    ProfileInfo(
                      label: 'Email',
                      value: state.userProfile['email'],
                      icon: Icons.email_outlined,
                    ),
                    verticalSpacer(20),
                    ProfileInfo(
                      label: 'Name',
                      value: state.userProfile['name'],
                      icon: Icons.person_outline,
                    ),
                    verticalSpacer(20),
                    Divider(color: getSecondary(context)),
                    verticalSpacer(4),
                    Row(
                      children: [
                        Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                        horizontalSpacer(20),
                        Text('Switch Theme', style: TextStyle(fontSize: 16)),
                        Spacer(),
                        CupertinoSwitch(
                          activeTrackColor: Colors.blue,
                          value: isDark,
                          onChanged: (v) {
                            context.read<ThemeBloc>().add(ToggleTheme());
                          },
                        ),
                      ],
                    ),
                    verticalSpacer(4),
                    Divider(color: getSecondary(context)),
                    verticalSpacer(20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            () => context.read<AuthBloc>().add(SignOut()),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.redAccent.shade200,
                        ),
                        icon: Icon(Icons.logout, color: Colors.white),
                        label: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
