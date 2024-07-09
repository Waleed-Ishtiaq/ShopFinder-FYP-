import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopfinder/CommonWidgets.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _emailController = TextEditingController();


  Future ForgetPassword() async{

    try {

          await FirebaseAuth.instance.sendPasswordResetEmail(
              email: _emailController.text.trim());

          ScaffoldMessenger.of(context).showSnackBar(
            snackBarWidget(message: "Password reset email send check your inbox"),
          );

        } on FirebaseAuthException catch(ex){
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarWidget(message: ex.code),
          );
        }
      }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            CircleAvatar(
              radius: 50,
                backgroundColor: Colors.red,
                child: Image.asset('assets/logo.png',width: 60,height: 60,),
            ),
            SizedBox(height: 60,),
            Text('Please enter valid email to send link for reset password'),
            SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email.....',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.red,
                    )
                  )
                ),
              ),
            ),
            SizedBox(height: 40,),
            ElevatedButton(
                onPressed: (){
                  ForgetPassword();
                },
                child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 25),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular( 25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
