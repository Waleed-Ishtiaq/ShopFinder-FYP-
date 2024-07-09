import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUserData(String id, String name, String email) async {

    try{
       await _db.collection('user').doc(id).set(
           {

             'name':name,
             'email':email,

           }
       );
    }
    on FirebaseException catch (e){
      {
        Fluttertoast.showToast(
          msg: e.code,
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          fontSize: 14.0,
          timeInSecForIosWeb: 3,
        );
      }
    }

  }



  Stream<DocumentSnapshot> getUserDataStream(String id){
    return _db.collection('user').doc(id).snapshots();
  }



}