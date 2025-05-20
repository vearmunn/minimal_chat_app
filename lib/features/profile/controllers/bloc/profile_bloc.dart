// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ProfileBloc({required this.firestore, required this.auth})
    : super(ProfileLoading()) {
    on<FetchCurrentUserProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final userDoc =
            await firestore.collection('Users').doc(event.currentUserID).get();
        emit(ProfileLoaded(userDoc.data() ?? {}));
      } catch (e) {
        emit(ProfileFailed(e.toString()));
      }
    });
  }
}
