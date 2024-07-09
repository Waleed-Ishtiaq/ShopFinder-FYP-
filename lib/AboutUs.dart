import 'package:flutter/material.dart';


class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          title: Text("About Us",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30,left: 15,right: 15),
                child: Text("Welcome to ShopFinder, your ultimate companion for seamless object detection and comprehensive online search capabilities. "
                    "At ShopFinder, we're committed to revolutionizing your shopping experience by leveraging cutting-edge technology to empower you with instant access to vital information about any object you encounter."
                    "With our innovative app, you can effortlessly detect and identify any object in your surroundings using the power of image recognition technology."
                    " Whether you're browsing in a store, exploring your neighborhood, or simply curious about an item, ShopFinder enables you to quickly scan and unlock a wealth of information at your fingertips."
                    "Our mission is to simplify the shopping process and empower consumers with transparent and insightful data. By harnessing the latest advancements in artificial intelligence and online connectivity, "
                    "ShopFinder seamlessly connects you to a vast network of retailers and online marketplaces, ensuring you have access to the most up-to-date and relevant information about products you're interested in."
                    "Key Features of ShopFinder:Object Detection: Instantly identify any object using our advanced image recognition technology. Simply point your camera, and let ShopFinder do the rest."
                    "Comprehensive Search: Retrieve detailed information about the detected object, including its availability, price range, current price, condition, and the stores where it's available."
                    "Real-Time Updates: Stay informed with real-time updates on product availability, pricing fluctuations, and new listings, ensuring you never miss out on the best deals."
                    "Store Locator: Easily locate nearby stores where the detected object is available, allowing you to make informed decisions about your purchases and conveniently plan your shopping trips."
                    "Personalized Recommendations: Receive personalized recommendations based on your preferences and shopping history, helping you discover new products tailored to your interests."
                    "At ShopFinder, we're dedicated to enhancing your shopping journey by providing you with the tools and information you need to make informed decisions and find the perfect products for your needs. "
                    "Join us on this exciting adventure as we redefine the way you shop and explore the world around you. Happy shopping with ShopFinder!"
                  ,style: TextStyle(color: Colors.black,fontSize: 14),),
              ),
            ],
            
          ),
        ),
      ),
    );
  }
}
