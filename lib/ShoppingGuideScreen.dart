import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shopfinder/CommonWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingGuideScreen extends StatefulWidget {

  final File? getImage;
  final String? getName;
  final String? countryCode;

  const ShoppingGuideScreen({super.key, this.getImage, this.getName, this.countryCode});

  @override
  State<ShoppingGuideScreen> createState() => _ShoppingGuideScreenState();
}

class _ShoppingGuideScreenState extends State<ShoppingGuideScreen> {

  List<Map<String, dynamic>> products = [];
  bool loadData = false;


  @override
  void initState() {
    super.initState();
    if(widget.getName != 'Not Detected') {
      fetchProductData();
    }
  }

  Future<void> fetchProductData() async {

    String? searchProduct = widget.getName;
    String? selectCountry = widget.countryCode;
    final url = Uri.parse('https://real-time-product-search.p.rapidapi.com/search?q=${searchProduct}&country=${selectCountry}&language=en');
    final headers = {
      'x-rapidapi-key': '6bcac40a33msh6716871586d212fp161d32jsn9517cfa55079',
      'x-rapidapi-host': 'real-time-product-search.p.rapidapi.com',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('data')) {
          final productsData = responseData['data'] as List<dynamic>;

          setState(() {
            products = productsData.map((data) => data as Map<String, dynamic>).toList();
            loadData = true;
          });
        }
      }
      else if(response.statusCode == 429){
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarWidget(message: "wait for minute because you are using free version of API"),
        );
      }
      else if(response.statusCode == 401){
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarWidget(message: "Unauthorized User"),
        );
      }
      else if(response.statusCode == 403){
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarWidget(message: "No permission to access the requested resources"),
        );
      }
      else if(response.statusCode == 404){
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarWidget(message: "Requested resources does not exist on the server"),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarWidget(message: response.statusCode.toString()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(message: error.toString()),
      );
    }


  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shopping Guide',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                child:
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width*0.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                        ),
                        child: widget.getImage!=null? Image.file(widget.getImage!,fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height*0.35,
                          width: MediaQuery.of(context).size.width*0.65,)
                            :Image.asset('assets/logo.png',fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height*0.35,
                          width: MediaQuery.of(context).size.width*0.65,
                        ),
                      ),
                    ),
              ),
              SizedBox(height: 10,),
              Text(widget.getName!,style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 3,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Similar Product',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 25),),
                ),
              ),
             //SizedBox(height: 5,),
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  child:FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      if (loadData ==false) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error loading page data.'),
                        );
                      } else {
                        // When the Future is complete, display the actual page content
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 50,top: 10,bottom: 10),
                              child: InkWell(
                                child: Container(

                                  height: MediaQuery.of(context).size.height*0.4,
                                  width: MediaQuery.of(context).size.width*0.6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 45),
                                          child: Image.network(product['product_photos'][0] ?? 'Not Available',height: 100,width: 100,fit: BoxFit.cover,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(product['product_title'] ?? 'N/A',
                                            style: TextStyle(color: Colors.lightBlue,fontSize: 18,fontWeight: FontWeight.bold),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text('Price Range: ${product['typical_price_range']?.join(' - ') ?? 'N/A'}'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text('Store: ${product['offer']['store_name'] ?? 'N/A'}'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text('Price: ${product['offer']['price'] ?? 'N/A'}'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text('Condition: ${product['offer']['product_condition'] ?? 'N/A'}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  // Navigate to the product page URL when tapped
                                  final productPageUrl = product['offer']['offer_page_url'] ?? '';
                                  if (productPageUrl.isNotEmpty) {
                                    launchURL(productPageUrl);
                                  }
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
              )

            ],
          ),
        ),
      ),
    );
  }
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

}
