import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopfinder/ForgotPasswordScreen.dart';
import 'package:shopfinder/LoginScreen.dart';
import 'package:shopfinder/HomeScreen.dart';

class CheckUserScreen extends StatelessWidget {
  const CheckUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData)
            {
              return HomeScreen();
            }
          else{
            return LoginScreen();
          }
        }
      ),
    );
  }
}
