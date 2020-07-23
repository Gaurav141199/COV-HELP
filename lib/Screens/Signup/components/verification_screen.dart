import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/Screens/main_page/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerificationScreen extends StatelessWidget {
  final String email;
  final String password;
  final String name;

  const VerificationScreen({this.email, this.password, this.name});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    Future<String> checkIfVerified(String email, String password) async {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user.isEmailVerified) return result.user.uid;
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
                String uid = await checkIfVerified(email, password);
                if (uid != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Main_page(
                        name: name,
                        email: email,
                        uid: uid,
                      ),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(msg: 'Email address not verified');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
