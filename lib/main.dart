import 'package:cov_help/Screens/main_page/main_page.dart';
import 'package:cov_help/services/navigation_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cov_help/Screens/Welcome/welcome_screen.dart';
import 'package:cov_help/Screens/constants.dart';
import 'package:cov_help/services/Provider.dart';
import 'package:cov_help/services/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cov_help/services/User.dart';
import 'package:get_it/get_it.dart';
import 'services/routes.dart' as router;

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Cov-help",
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: kPrimaryColor,
          ),
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        home: HomeController(),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    String name = '';
    String email = '';
    String uid = '';

    Future<String> get() async {
      name = await auth.getUserName();
      email = await auth.getEmail();
      uid = await auth.getCurrentUID();
      bool check = await auth.checkVerified();
      if (check) return "pass";
      auth.signOut();
      return 'fail';
    }

    Future _future = get();

    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return (signedIn)
              ? FutureBuilder(
                  future: _future,
                  builder: (context, snapshot1) {
                    print("hey");
                    print(snapshot1.data);
                    if (snapshot1.hasData) {
                      if (snapshot1.data == 'fail') {
                        return WelcomeScreen();
                      } else {
                        user1.name = name;
                        user1.email = email;
                        user1.uid = uid;
                        return Main_page(
                          name: name,
                          email: email,
                          uid: uid,
                        );
                      }
                    } else
                      return SpinKitDoubleBounce(
                        color: kPrimaryColor,
                        size: 50,
                      );
                  },
                )
              : WelcomeScreen();
        }
        return SpinKitDoubleBounce(
          color: kPrimaryColor,
          size: 50.0,
        );
      },
    );
  }
}
