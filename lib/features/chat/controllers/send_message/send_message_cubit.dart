import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/message.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SendMessageCubit({required this.firestore, required this.auth})
    : super(SendMessageInitial());
  void sendMessage({required String receiverID, message}) async {
    // get current user info
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // this ensure the chatroomID is the same for any 2 people
    String chatRoomID = ids.join('_');

    // add new maessage to database
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
    emit(MessageSent('Nice'));
  }
}
