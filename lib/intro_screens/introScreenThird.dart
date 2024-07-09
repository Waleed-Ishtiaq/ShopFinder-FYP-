import 'package:flutter/material.dart';

class IntroScreenThird extends StatelessWidget {
  const IntroScreenThird({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white54,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.15),
            Image.asset('assets/intro3.jpeg',width: 225,height: 225,),
            SizedBox(height: 35,),
            Text("Select Your Favorite Item",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text('Select your favorite item or appropriate object in all the available stores.',
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
