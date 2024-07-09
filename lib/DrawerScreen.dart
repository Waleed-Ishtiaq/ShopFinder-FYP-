import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopfinder/AboutUs.dart';
import 'package:shopfinder/DatabaseServices/dbServices.dart';
import 'package:shopfinder/LoginScreen.dart';
import 'package:shopfinder/CommonWidgets.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future signOut() async {
      if (FirebaseAuth.instance.currentUser != null) {
        try {
          await FirebaseAuth.instance.signOut();

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen(),));

          ScaffoldMessenger.of(context).showSnackBar(
            snackBarWidget(message: "Successfully logout"),
          );

        } on FirebaseAuthException catch (exx) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarWidget(message: exx.code),
          );
        }
      }
    }



    User? user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
        stream: user != null
            ? DatabaseService().getUserDataStream(user.uid)
            : null,
        builder: (context, snapshot) {

          String name = snapshot.data?['name']?? ' ';
          String email = snapshot.data?['email']?? ' ';

          return Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/appicon.png'),
                          backgroundColor: Colors.red,
                          radius: 35,
                        ),
                        SizedBox(height: 10,),
                        Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: 3,),
                        Text(email, style: TextStyle(color: Colors.white, fontSize: 15),),
                      ],
                    ),
                  ),
                  SizedBox(height: 23,),
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.red),
                    title: Text('Home', style: TextStyle(color: Colors.red),),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 1,),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.red,),
                    title: Text(
                      'About Us', style: TextStyle(color: Colors.red),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs(),));
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red,),
                    title: Text(
                      'Log Out', style: TextStyle(color: Colors.red),),
                    onTap: () {
                      signOut();
                    },
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}





