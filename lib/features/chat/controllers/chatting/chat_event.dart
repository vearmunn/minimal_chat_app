part of 'chat_bloc.dart';

sealed class ChatEvent {}

class GetMessagesStream extends ChatEvent {
  final String userID;
  final String otherUserID;

  GetMessagesStream({required this.userID, required this.otherUserID});
}

class MessagesUpdated extends ChatEvent {
  final QuerySnapshot messages;

  MessagesUpdated(this.messages);
}

// class SendMessage extends ChatEvent {
//   final String receiverID;
//   final String message;

//   SendMessage(this.receiverID, this.message);
// }
