import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmail(String email , String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      print(e.message);
    }
  }

  Future signInWithEmail(String email , String password)async{
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Sign in successful
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message on failure
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

}