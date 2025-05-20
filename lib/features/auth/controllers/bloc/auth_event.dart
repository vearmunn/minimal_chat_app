part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class SignInWithGoogle extends AuthEvent {}

final class SignOut extends AuthEvent {}

final class GetCurrentUser extends AuthEvent {}
