part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserCredential? userCredential;

  AuthSuccess(this.userCredential);
}

final class AuthFailed extends AuthState {
  final String errorMessage;

  AuthFailed(this.errorMessage);
}

final class CurrentUserObtained extends AuthState {
  final User? user;

  CurrentUserObtained(this.user);
}
