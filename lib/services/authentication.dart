import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map(
            (FirebaseUser user) => user?.uid,
      );

  //Get User
  Future getUser() async{
    return await _firebaseAuth.currentUser();
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //Get email
  Future<String> getEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  //Get name

  Future<String> getUserName() async{
    return (await _firebaseAuth.currentUser()).displayName;
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(String email, String password,
      String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Update the username
    await updateUserName(name, authResult.user);
    try {
      await authResult.user.sendEmailVerification();
      return authResult.user.uid;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }

    return authResult.user.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }


  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    AuthResult result  = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if(result.user.isEmailVerified) return result.user.uid;
    return 'NO';
  }

  // Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return  await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //check verification


}