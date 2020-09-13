import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //checks if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Error ${snapshot.error}")));
        }

        //checking connection to firebase
        if (snapshot.connectionState == ConnectionState.done) {
          //checks login state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, s) {
              if (s.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('error ${s.error}'),
                  ),
                );
              }

              //checking if user is already logged in
              if (s.connectionState == ConnectionState.active) {
                User _user = s.data;
                if (_user == null) {
                  //user not logged in
                  return LoginPage();
                } else {
                  //user already logged in
                  HomePage();
                }
              } //connection loading screen
            },
          );
        }

        //connection loading screen
        return Scaffold(body: Center(child: Text("Initializing App")));
      },
    );
  }
}
