// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//   // User? getCurrentUser() {
//   //   return _auth.currentUser;
//   // }

//   // Future<UserCredential> signIn(String email, String password) async {
//   //   try {
//   //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );

//   //     // save user info if it doesn't exist
//   //     _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
//   //       'uid': userCredential.user!.uid,
//   //       'email': email,
//   //     });
//   //     return userCredential;
//   //   } on FirebaseAuthException catch (e) {
//   //     throw Exception(e);
//   //   }
//   // }

//   // Future<UserCredential> signUp(String email, String password) async {
//   //   try {
//   //     UserCredential userCredential = await _auth
//   //         .createUserWithEmailAndPassword(email: email, password: password);

//   //     _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
//   //       'uid': userCredential.user!.uid,
//   //       'email': email,
//   //     });
//   //     return userCredential;
//   //   } on FirebaseAuthException catch (e) {
//   //     throw Exception(e);
//   //   }
//   // }

//   // Future<UserCredential?> signInWithGoogle() async {
//   //   // begin interactive sign in process
//   //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//   //   if (gUser == null) return null;

//   //   // obtain auth deails from request
//   //   final GoogleSignInAuthentication gAuth = await gUser.authentication;

//   //   // create a new credential for user
//   //   final credential = GoogleAuthProvider.credential(
//   //     accessToken: gAuth.accessToken,
//   //     idToken: gAuth.idToken,
//   //   );

//   //   final UserCredential userCredential = await _auth.signInWithCredential(
//   //     credential,
//   //   );

//   //   _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set({
//   //     'uid': userCredential.user!.uid,
//   //     'email': userCredential.user!.email,
//   //   });

//   //   return userCredential;
//   // }

//   // Future signOut() async {
//   //   await GoogleSignIn().signOut();
//   //   await _auth.signOut();
//   // }
// }
