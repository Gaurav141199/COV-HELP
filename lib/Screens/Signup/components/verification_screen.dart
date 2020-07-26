import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/Screens/main_page/main_page.dart';
import 'package:cov_help/services/User.dart';
import 'package:cov_help/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerificationScreen extends StatelessWidget {
  final String email;
  final String password;
  final String name;
  AuthService _authMethods = AuthService();

  VerificationScreen({this.email, this.password, this.name});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    void authenticateUser(FirebaseUser user) {
      _authMethods.authenticateUser(user).then((isNewUser) {
        if (isNewUser) {
          _authMethods.addDataToDb(user).then(
            (value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Main_page(
                    name: name,
                    email: email,
                    uid: user.uid,
                  ),
                ),
              );
            },
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Main_page(
                  name: name,
                  email: email,
                  uid: user.uid,
                );
              },
            ),
          );
        }
      });
    }

    Future<String> checkIfVerified(String email, String password) async {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user.isEmailVerified) {
        authenticateUser(result.user);
        return result.user.uid;
      }
      return null;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("Please check your email"),
            ),
            MaterialButton(
              color: Colors.green,
              child: Text("I verified the email"),
              onPressed: () async {
                await checkIfVerified(email, password);
              },
            ),
          ],
        ),
      ),
    );
  }
}
