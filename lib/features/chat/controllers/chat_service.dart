// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:minimal_chat_app/features/chat/models/message.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}

// class ChatService {
//   // get instance of firestore
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   // get user stream
//   Stream<List<Map<String, dynamic>>> getUsersStream() {
//     return _firestore
//         .collection('Users')
//         .where('email', isNotEqualTo: auth.currentUser!.email)
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs.map((doc) {
//             final user = doc.data();
//             return user;
//           }).toList();
//         });
//   }

//   // send message
//   Future sendMessage(String receiverID, message) async {
//     // get current user info
//     final String currentUserID = auth.currentUser!.uid;
//     final String currentUserEmail = auth.currentUser!.email!;
//     final Timestamp timestamp = Timestamp.now();

//     // create a new message
//     Message newMessage = Message(
//       senderID: currentUserID,
//       senderEmail: currentUserEmail,
//       receiverID: receiverID,
//       message: message,
//       timestamp: timestamp,
//     );

//     // construct chat room ID for the two users (sorted to ensure uniqueness)
//     List<String> ids = [currentUserID, receiverID];
//     ids.sort(); // this ensure the chatroomID is the same for any 2 people
//     String chatRoomID = ids.join('_');

//     // add new maessage to database
//     await _firestore
//         .collection('chat_rooms')
//         .doc(chatRoomID)
//         .collection('messages')
//         .add(newMessage.toMap());
//   }

//   // get messages
//   // Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
//   //   // construct a chatroom ID for the two users
//   //   List<String> ids = [userID, otherUserID];
//   //   ids.sort();
//   //   String chatRoomID = ids.join('_');

//   //   return _firestore
//   //       .collection('chat_rooms')
//   //       .doc(chatRoomID)
//   //       .collection('messages')
//   //       .orderBy('timestamp', descending: false)
//   //       .snapshots();
//   // }
// }
