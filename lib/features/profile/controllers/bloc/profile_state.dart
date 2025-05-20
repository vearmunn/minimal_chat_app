part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userProfile;

  ProfileLoaded(this.userProfile);
}

final class ProfileFailed extends ProfileState {
  final String errorMessage;

  ProfileFailed(this.errorMessage);
}
