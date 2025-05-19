// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/features/auth/controllers/auth_service.dart';
import 'package:minimal_chat_app/features/chat/controllers/chat_service.dart';
import 'package:minimal_chat_app/widgets/custom_textfield.dart';

import '../../../widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated
        // then scroll down
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    myFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 700),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverEmail)),
      body: Column(children: [_buildMessageList(), _buildMessageTextField()]),
    );
  }

  Widget _buildMessageList() {
    return Expanded(
      child: StreamBuilder(
        stream: _chatService.getMessages(
          widget.receiverID,
          _authService.getCurrentUser()!.uid,
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(20),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              bool isCurrentUser =
                  snapshot.data.docs[index]['senderID'] ==
                  _authService.getCurrentUser()!.uid;
              return ChatBubble(
                text: snapshot.data.docs[index]['message'],
                isCurrentUser: isCurrentUser,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMessageTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
      child: Row(
        children: [
          Expanded(
            child: CustomTextfield(
              hintText: 'Your message...',
              obscure: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
