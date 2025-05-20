import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_chat_app/features/auth/controllers/bloc/auth_bloc.dart';
import 'package:minimal_chat_app/features/chat/controllers/users/users_bloc.dart';
import 'package:minimal_chat_app/features/chat/pages/chat_page.dart';
import 'package:minimal_chat_app/utils/spacer.dart';

import '../../../utils/get_colors.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    context.read<UsersBloc>().add(StartUserStream());
    context.read<AuthBloc>().add(GetCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message_rounded, color: getPrimary(context)),
            horizontalSpacer(8),
            Text(
              'Mini Chat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getPrimary(context),
              ),
            ),
          ],
        ),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is UsersError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        if (state is UsersLoaded) {
          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: state.users.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        state.users[index]['name'],
                        style: TextStyle(),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ChatPage(
                                  receiverID: state.users[index]['uid'],
                                  receiverName: state.users[index]['name'],
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

  // Widget _buildUserList() {
  //   return StreamBuilder(
  //     stream: chatService.getUsersStream(),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       if (snapshot.hasError) {
  //         return Center(child: Text('Error'));
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //   return ListView.builder(
  //     padding: EdgeInsets.all(20),
  //     itemCount: snapshot.data.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Padding(
  //         padding: const EdgeInsets.only(bottom: 12.0),
  //         child: ListTile(
  //           leading: Icon(Icons.person_4_rounded),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           tileColor: getPrimary(context),
  //           title: Text(
  //             snapshot.data[index]['email'],
  //             style: TextStyle(color: getOnPrimary(context)),
  //           ),
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder:
  //                     (context) => ChatPage(
  //                       receiverID: snapshot.data[index]['uid'],
  //                       receiverEmail: snapshot.data[index]['email'],
  //                     ),
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // },
  //   );
  // }