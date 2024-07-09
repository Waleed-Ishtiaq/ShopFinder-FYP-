import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinder/LoginScreen.dart';
import 'package:shopfinder/intro_screens/introScreenOne.dart';
import 'package:shopfinder/intro_screens/introScreenThird.dart';
import 'package:shopfinder/intro_screens/introScreenTwo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MainIntroScreen extends StatefulWidget {
  const MainIntroScreen({super.key});

  @override
  State<MainIntroScreen> createState() => _MainIntroScreenState();
}

class _MainIntroScreenState extends State<MainIntroScreen> {

  PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(

            controller:  _controller,
            onPageChanged: (index) {
              if (index == 2) {
                setState(() {
                  isLastPage = true;
                });
              }
              else{
                setState(() {
                  isLastPage = false;
                });
              }
            },
            children: [
              IntroScreenOne(),
              IntroScreenTwo(),
              IntroScreenThird(),
            ],
          ),

          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                InkWell(
                    child: Text('Skip'),
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                ),

                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotHeight: 14,
                      dotWidth: 14,
                      dotColor: Colors.grey,
                    activeDotColor: Colors.red,
                  ),
                  controller: _controller,
                  count: 3,
                ),

                (isLastPage)?InkWell(
                    child: Text('Done'),
                  onTap: () async{
                    final SharedPreferences sharedPrefences = await SharedPreferences.getInstance();
                    sharedPrefences.setString('response', 'yes');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                  },
                ):InkWell(
                  child: Text('Next'),
                  onTap: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 635),
                      curve: Curves.ease,
                    );
                  },
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

