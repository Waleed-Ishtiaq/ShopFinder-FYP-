import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopfinder/CheckUserScreen.dart';
import 'package:shopfinder/CommonWidgets.dart';
import 'package:shopfinder/DatabaseServices/dbServices.dart';
import 'package:shopfinder/ForgotPasswordScreen.dart';
import 'package:shopfinder/HomeScreen.dart';
import 'package:shopfinder/SignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


   final _emailController = TextEditingController();
   final _passwordController = TextEditingController();

   GlobalKey<FormState> globalKey = GlobalKey<FormState>();


   Future login() async{
     try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: _emailController.text.trim(), password: _passwordController.text.trim());

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

       //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

     } on FirebaseAuthException catch(e){


         ScaffoldMessenger.of(context).showSnackBar(
           snackBarWidget(message: e.code),
         );


     }
   }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Image.asset('assets/logo.png',width: 120,height: 120,),
                      SizedBox(height: 20,),
                      Text('ShopFinder',style: TextStyle(decoration: TextDecoration.none,color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 25),),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width:MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60),
                        )
                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 25,top: 45),
                            child: Text('LOGIN',style: TextStyle(decoration: TextDecoration.none,color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Text('Do not have an account?',style: TextStyle(decoration: TextDecoration.none,fontSize: 12),),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                                  },
                                  child: Text(' Register',style: TextStyle(color: Colors.blue),),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Form(
                                key: globalKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.85,
                                      child: TextFormField(

                                          controller: _emailController,
                                          validator: (value){
                                            if(value!.isEmpty)
                                            {
                                              return ' please enter email';
                                            }
                                            else{
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Your Email',
                                              prefixIcon: Icon(Icons.email,size: 28,color: Colors.red,),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                              )
                                          )
                                      ),
                                    ),
                                    SizedBox(height: 10,),

                                    // Password TextFormField
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.85,
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        validator: (value){
                                          if(value!.isEmpty)
                                          {
                                            return ' please enter password';
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter Your password',
                                          prefixIcon: Icon(Icons.person,size:28,color: Colors.red,),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 60,top: 14),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                                            },
                                            child: Text('Forget Password?',style: TextStyle(color: Colors.blue),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          elevation: 4,
                                          shadowColor: Colors.blueGrey,
                                          fixedSize: Size(MediaQuery.of(context).size.width*0.8, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          )
                                      ),
                                      onPressed: () async {

                                        if(globalKey.currentState!.validate()){

                                          login();  // call login function
                                        }
                                      },
                                      child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(height: 10,),



                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                )

              ],
            )
        ),
      ),
    );
  }
}
