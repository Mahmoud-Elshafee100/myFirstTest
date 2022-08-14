import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'abstract_repo/abstract_auth_repo.dart';

/*
* repo class for the auth
* */
class FirebaseAuthenticationRepository extends AuthRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

/*
* sign in func
* */
  @override
  Future<UserCredential?> signIn({required String email,required String password}) async{
    try {
      if (await _auth.currentUser != null){
        signOut();
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      String idToken=await userCredential.user!.getIdToken();
      final User user = userCredential.user!;
      var userData = {
        'email': userCredential.user!.email,
      };
      users.doc(user.uid).get().then((doc) {
        if (doc.exists) {
          doc.reference.update(userData);
        } else {
          users.doc(user.uid).set(userData);
        }
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log("e : ${e}");
      return null;
    }
  }
/*
* sign out func
* */
  @override
  Future<void> signOut() async{
    await _auth.signOut();
  }

}
