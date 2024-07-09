import 'dart:convert';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinder/AI_Integration/image_classifier.dart';
import 'package:shopfinder/AboutUs.dart';
import 'package:shopfinder/CommonWidgets.dart';
import 'package:shopfinder/DrawerScreen.dart';
import 'package:shopfinder/LoginScreen.dart';
import 'package:shopfinder/ShoppingGuideScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? pickedImage;
  String? _result;
  String productName = '';
  late ImagePicker _imagePicker;
  String _countryCode = ' ';
  final ImageClassifier _classifier = ImageClassifier();

  @override
  void initState() {
    super.initState();
    _classifier.loadModel();
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
      final prediction = await _classifier.classifyImage(pickedImage!);
      setState(() {
        _result = prediction;
      });
    }
  }

  @override
  void dispose() {
    _classifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        title: Text(
          'ShopFinder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.red,
                ),
                child: pickedImage != null
                    ? Image.file(
                  pickedImage!,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.7,
                )
                    : Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Pick Image From',
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _getImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                elevation: 4,
                                shadowColor: Colors.blueGrey,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.7,
                                    50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _getImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cloud_upload_outlined,
                                      color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                elevation: 4,
                                shadowColor: Colors.blueGrey,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.7,
                                    50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                elevation: 4,
                                shadowColor: Colors.blueGrey,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.7,
                                    50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Take Image',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 4,
                shadowColor: Colors.blueGrey,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.red,
                    ),
                    child: Text(
                      'Select Country:',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                CountryListPick(
                  theme: CountryTheme(
                    isShowFlag: false,
                    isShowCode: false,
                  ),
                  onChanged: (CountryCode? value) {
                    setState(() {
                      _countryCode = value!.code!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 50),

            // Start Processing Button
            pickedImage != null && _countryCode != null
                ? ElevatedButton(
              onPressed: () {
                _result != null
                    ? _result!.isEmpty
                    ? Center(child: Text('Image not detected'))
                    : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingGuideScreen(
                      getImage: pickedImage,
                      getName: _result,
                      countryCode: _countryCode!,
                    ),
                  ),
                )
                    : Center(child: Text('Image not detected'));
              },
              child: Text(
                'Start Processing',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 4,
                shadowColor: Colors.blueGrey,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
