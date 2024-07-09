
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopfinder/CommonWidgets.dart';
import 'package:shopfinder/DatabaseServices/dbServices.dart';
import 'package:shopfinder/HomeScreen.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
    SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  // Variables to store data
   String name=" ",email=" ",password=" ";


  // User creation process
  Future<void> signUp() async{

    name = _nameController.text.trim();
    email = _emailController.text.trim();
    password = _passwordController.text.trim();

    try {
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

        ScaffoldMessenger.of(context).showSnackBar(
          snackBarWidget(message: " Account Successfully Created"),
        );

     await DatabaseService().addUserData(userCredential.user!.uid, name, email);

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
                           padding: const EdgeInsets.only(left: 25,top: 65),
                           child: Text('REGISTER',style: TextStyle(decoration: TextDecoration.none,color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 25),
                           child: Row(
                             children: [
                               Text('Already have an account?',style: TextStyle(decoration: TextDecoration.none,fontSize: 12),),
                               InkWell(
                                 onTap: (){
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                 },
                                   child: Text(' Login',style: TextStyle(color: Colors.blue),),
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

                                 // Name TextFormField
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width*0.85,
                                   child: TextFormField(
                                     controller: _nameController,

                                     validator: (value){
                                       if(value!.isEmpty)
                                       {
                                         return ' please enter name';
                                       }
                                       else{
                                         return null;
                                       }
                                     },
                                     decoration: InputDecoration(

                                       hintText: 'Enter Your name',
                                       prefixIcon: Icon(Icons.person,size:28,color: Colors.red,),
                                       border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(50),
                                         borderSide: BorderSide(
                                         ),
                                       ),
                                   ),
                                   ),
                                 ),

                                 SizedBox(height: 10,),

                                  // Email TextFormField
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


                                 SizedBox(height: 30,),
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
                                   onPressed:(){
                                       if(globalKey.currentState!.validate()){
                                         signUp();
                                       }
                                   },

                                   child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                                 ),
                                 SizedBox(height: 50,),

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




