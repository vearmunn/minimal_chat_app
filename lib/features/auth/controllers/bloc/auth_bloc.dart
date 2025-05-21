// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthBloc({required this.auth, required this.firestore})
    : super(AuthInitial()) {
    on<SignInWithGoogle>((event, emit) async {
      try {
        // begin interactive sign in process
        final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

        if (gUser == null) return;

        emit(AuthLoading());

        // obtain auth deails from request
        final GoogleSignInAuthentication gAuth = await gUser.authentication;

        // create a new credential for user
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        final UserCredential userCredential = await auth.signInWithCredential(
          credential,
        );

        firestore.collection('Users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'name': gUser.displayName,
        });

        emit(AuthSuccess(userCredential));
      } on FirebaseAuthException catch (e) {
        emit(AuthFailed(e.message!));
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
    on<SignOut>((event, emit) async {
      await GoogleSignIn().signOut();
      await auth.signOut();
    });
    on<GetCurrentUser>((event, emit) {
      emit(CurrentUserObtained(auth.currentUser));
    });
  }
}
