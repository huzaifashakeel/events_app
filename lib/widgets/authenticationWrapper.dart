import 'package:events_app/screens/loginPage.dart';
import 'package:events_app/widgets/botttomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// used to display login screen if not logged in or
/// display home screen if logged in.
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? _firebaseUser = context.watch<User?>();
    if (_firebaseUser != null) {
      // BottomNavBar widget adds a Persistent Navigation Bar which
      // stays across all screens. Home screen and other pages are
      // added in this widget.
      return BottomNavBar(useremail: _firebaseUser.email.toString(),);
    }
    // if user is not logged in
    return LoginPage();
  }
}
