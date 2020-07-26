import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cov_help/services/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
//  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //Get User
  Future getUser() async {
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

  Future<bool> isEmailVerified() async {
    return await _firebaseAuth
        .currentUser()
        .then((value) => value.isEmailVerified);
  }

  //Get name

  Future<String> getUserName() async {
    return (await _firebaseAuth.currentUser()).displayName;
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Update the username
    await updateUserName(name, authResult.user);
    try {
      await authResult.user.sendEmailVerification();
      if (authResult.user.isEmailVerified) {
        return authResult.user.uid;
      } else {
        return null;
      }
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }

    return authResult.user.uid;
  }

  //To check if user is new
  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await _firestore
        .collection("users")
        .where('email', isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    User user = User(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoUrl,
    );

    _firestore
        .collection("users")
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (result.user.isEmailVerified) return result.user.uid;
    return 'NO';
  }

  // Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //check verification

}
