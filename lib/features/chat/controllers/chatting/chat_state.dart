part of 'chat_bloc.dart';

sealed class ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final QuerySnapshot messages;

  ChatLoaded(this.messages);
}

final class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
