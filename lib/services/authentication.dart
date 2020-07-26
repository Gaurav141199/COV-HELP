import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
    var user = await _firebaseAuth.currentUser();
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future checkVerified() async {
    var user = await _firebaseAuth.currentUser();
    if (user != null) {
      return user.isEmailVerified;
    } else {
      return null;
    }
  }

  //Get email
  Future<String> getEmail() async {
    var user = await _firebaseAuth.currentUser();
    if (user != null) {
      return user.email;
    } else {
      return null;
    }
  }

  //Get name

  Future<String> getUserName() async {
    var user = await _firebaseAuth.currentUser();
    if (user != null) {
      var name = user.displayName;
      print(name);
      return name;
    }
    return null;
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
    return null;
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
