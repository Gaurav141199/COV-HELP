import 'package:flutter/material.dart';

class ScreenArguments {
  final String name;
  final String email;
  final String password;
  final String uid;

  ScreenArguments(this.name, this.email, this.uid, this.password);
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName, {ScreenArguments arguments}) {
    return navigatorKey.currentState.pushNamed(
      routeName,
      arguments: ScreenArguments(
          arguments.name, arguments.email, arguments.uid, arguments.password),
    );
  }
}
