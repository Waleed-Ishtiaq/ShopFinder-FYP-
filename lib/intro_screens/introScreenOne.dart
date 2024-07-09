import 'package:flutter/material.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white54,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.15),
           Image.asset('assets/intro1.jpeg',width: 200,height: 200,),
            SizedBox(height: 35,),
            Text("Upload Your Picture",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,

              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text('Upload your picture from Gallery or Capture Picture from Camera.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
