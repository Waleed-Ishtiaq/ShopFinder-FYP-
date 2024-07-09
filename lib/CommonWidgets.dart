import 'package:flutter/material.dart';


SnackBar snackBarWidget({required String message}) {
   return  SnackBar(
     backgroundColor: Colors.red,
     elevation: 7,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
     duration: Duration(seconds: 2),
     content: Text(message),
   );
  }



