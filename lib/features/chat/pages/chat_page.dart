// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_chat_app/features/chat/controllers/chat_service.dart';
import 'package:minimal_chat_app/features/chat/controllers/send_message/send_message_cubit.dart';
import 'package:minimal_chat_app/utils/get_exact_time.dart';
import 'package:minimal_chat_app/widgets/custom_textfield.dart';

import '../../../widgets/chat_bubble.dart';
import '../controllers/chatting/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  final String receiverName;
  final String receiverID;
  const ChatPage({
    super.key,
    required this.receiverName,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  FocusNode myFocusNode = FocusNode();
  late final ScrollController _scrollController;
  final chatService = ChatService();

  @override
  void initState() {
    _scrollController = ScrollController();
    context.read<ChatBloc>().add(
      GetMessagesStream(
        userID: chatService.getCurrentUser()!.uid,
        otherUserID: widget.receiverID,
      ),
    );
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated
        // then scroll down
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
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
      context.read<SendMessageCubit>().sendMessage(
        receiverID: widget.receiverID,
        message: _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.receiverName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(children: [_buildMessageList(), _buildMessageTextField()]),
    );
  }

  Widget _buildMessageList() {
    return Expanded(
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded) {
            Future.delayed(Duration(milliseconds: 500), () => scrollDown());
          }
        },
        builder: (context, state) {
          if (state is ChatError) {
            return Text(state.message);
          }
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ChatLoaded) {
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(20),
              itemCount: state.messages.docs.length,
              itemBuilder: (BuildContext context, int index) {
                bool isCurrentUser =
                    state.messages.docs[index]['senderID'] ==
                    chatService.getCurrentUser()!.uid;

                return ChatBubble(
                  text: state.messages.docs[index]['message'],
                  time: getExactTime(
                    state.messages.docs[index]['timestamp'].toDate(),
                  ),
                  isCurrentUser: isCurrentUser,
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMessageTextField() {
    return BlocListener<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is MessageSent) {
          scrollDown();
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 20, 20),
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
      ),
    );
  }
}
