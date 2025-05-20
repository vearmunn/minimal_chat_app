part of 'users_bloc.dart';

sealed class UsersEvent {}

class StartUserStream extends UsersEvent {}

class UsersUpdated extends UsersEvent {
  final List<Map<String, dynamic>> users;
  UsersUpdated(this.users);
}
