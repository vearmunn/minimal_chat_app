part of 'send_message_cubit.dart';

sealed class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}

final class MessageSent extends SendMessageState {
  final String message;

  MessageSent(this.message);
}
