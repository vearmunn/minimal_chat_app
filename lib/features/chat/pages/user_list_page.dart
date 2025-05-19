import 'package:flutter/material.dart';
import 'package:minimal_chat_app/features/chat/controllers/chat_service.dart';
import 'package:minimal_chat_app/features/chat/pages/chat_page.dart';

import '../../../utils/get_colors.dart';

class UserListPage extends StatelessWidget {
  UserListPage({super.key});

  final chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minimal Chat App'), centerTitle: true),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ListTile(
                leading: Icon(Icons.person_4_rounded),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: getTertiary(context),
                title: Text(snapshot.data[index]['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ChatPage(
                            receiverID: snapshot.data[index]['uid'],
                            receiverEmail: snapshot.data[index]['email'],
                          ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
