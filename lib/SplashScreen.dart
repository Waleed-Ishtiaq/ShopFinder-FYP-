import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopfinder/CheckUserScreen.dart';
import 'package:shopfinder/HomeScreen.dart';
import 'package:shopfinder/intro_screens/mainIntroScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String obtainResponse;

  @override
  void initState() {
    super.initState();
    initialize();
  }

   initialize()  async{
   await sharePreferenceFunction();
    Timer(
      Duration(seconds: 4),
          () {
        (obtainResponse == 'yes')
            ? Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CheckUserScreen(),
          ),
        )
            : Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainIntroScreen(),
          ),
        );
      },
    );
  }

  Future<void> sharePreferenceFunction() async {
    final SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();
    var sharedResponse = _sharedPreferences.getString('response') ?? '';
    setState(() {
      obtainResponse = sharedResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitDoubleBounce(
              itemBuilder: (context, index) {
                return Image.asset('assets/logo.png');
              },
              size: 250,
              duration: Duration(seconds: 3),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'ShopFinder',
              style: TextStyle(
                color: Colors.white70,
                decoration: TextDecoration.none,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
