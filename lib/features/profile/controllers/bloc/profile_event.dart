part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class FetchCurrentUserProfile extends ProfileEvent {
  final String currentUserID;

  FetchCurrentUserProfile(this.currentUserID);
}
