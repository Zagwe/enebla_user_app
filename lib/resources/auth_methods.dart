import 'dart:typed_data';
import 'package:enebla_user_app/models/usermodel.dart' as model;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/resources/storage_methods.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/login.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signupUser(
      {required String email,
      required String password,
      required String firstname,
      required String lastname,
      required String phonenumber,
      required String address,
      required Uint8List file}) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String res = 'some error occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstname.isNotEmpty ||
          lastname.isNotEmpty ||
          address.isNotEmpty ||
          phonenumber.isNotEmpty ||
          file != null) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImgeToStorage('profilePics', file, false);

        model.User user = model.User(
            firstname: firstname,
            uid: _auth.currentUser!.uid,
            lastname: lastname,
            email: email,
            phonenumber: phonenumber,
            address: address,
            photoUrl: photoUrl);

        await _firestore.collection('users').doc(credential.user!.uid).set(
              user.toJson(),
            );

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging user in
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please enter all the fields';
      }
    }
    //// if you want to display custom error messages for users this is how you do it
    // on FirebaseAuthException catch(err){
    //   if(err.code == 'wrong-password'){
    //     //do something here
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
