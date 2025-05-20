// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  Stream<QuerySnapshot>? _chatStream;
  StreamSubscription? _chatSub;

  ChatBloc({required this.firestore, required this.auth})
    : super(ChatLoading()) {
    on<GetMessagesStream>((event, emit) {
      emit(ChatLoading());

      _chatSub?.cancel();

      // construct a chatroom ID for the two users
      List<String> ids = [event.userID, event.otherUserID];
      ids.sort();
      String chatRoomID = ids.join('_');

      _chatStream =
          firestore
              .collection('chat_rooms')
              .doc(chatRoomID)
              .collection('messages')
              .orderBy('timestamp', descending: false)
              .snapshots();
      _chatSub = _chatStream!.listen(
        (messages) => add(MessagesUpdated(messages)),
        onError: (e) => emit(ChatError(e.toString())),
      );
    });
    on<MessagesUpdated>((event, emit) {
      emit(ChatLoaded(event.messages));
    });
  }
  @override
  Future<void> close() {
    _chatSub?.cancel();
    return super.close();
  }
}
