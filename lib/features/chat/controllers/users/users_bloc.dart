import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  Stream<List<Map<String, dynamic>>>? _userStream;
  StreamSubscription? _userSub;

  UsersBloc({required this.firestore, required this.auth})
    : super(UsersLoading()) {
    on<StartUserStream>((event, emit) {
      emit(UsersLoading());

      _userSub?.cancel(); // Avoid multiple listeners

      _userStream = firestore
          .collection('Users')
          .where('email', isNotEqualTo: auth.currentUser!.email)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

      _userSub = _userStream!.listen(
        (users) => add(UsersUpdated(users)),
        onError: (e) => emit(UsersError(e.toString())),
      );
    });
    on<UsersUpdated>((event, emit) {
      emit(UsersLoaded(event.users));
    });
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    return super.close();
  }
}
