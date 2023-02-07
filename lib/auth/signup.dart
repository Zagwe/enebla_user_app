import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/auth/login.dart';
import 'package:enebla_user_app/models/usermodel.dart' as model;
import 'package:enebla_user_app/resources/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _signupState();
}

class _signupState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final firstnameEditingController = TextEditingController();
  final lastnameEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final conformPasswordEditingController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstname = TextFormField(
      autofocus: false,
      controller: firstnameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("first name cannot be empty");
        }

        if (!regex.hasMatch(value)) {
          return ("please enter valid first name(min. 3 charater)");
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "first name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final lastname = TextFormField(
      autofocus: false,
      controller: lastnameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("last name cannot be empty");
        }

        if (!regex.hasMatch(value)) {
          return ("please enter valid last name(min. 3 charater)");
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "last name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final phoneNumber = TextFormField(
      autofocus: false,
      controller: phoneNumberEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value?.length != 10)
          return 'Mobile Number must be of 10 digit';
        else
          return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "phoneNumber",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("password is required for login");
        }

        if (!regex.hasMatch(value)) {
          return ("please enter valid password(min. 6 charater)");
        }
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final conformPassword = TextFormField(
      autofocus: false,
      controller: conformPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (conformPasswordEditingController.text !=
            passwordEditingController.text) {
          return "password dont match";
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "conformPassword",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final address = TextFormField(
      autofocus: false,
      controller: addressController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("the address is empty");
        }
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "address",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          // signup(emailEditingController.text, passwordEditingController.text);

          if (_formkey.currentState!.validate()) {
            String res = await AuthMethods().signupUser(
                email: emailEditingController.text,
                password: passwordEditingController.text,
                firstname: firstnameEditingController.text,
                lastname: lastnameEditingController.text,
                phonenumber: phoneNumberEditingController.text,
                address: addressController.text);
            if (res == 'success') {
              Fluttertoast.showToast(msg: 'account created successfully');

              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (router) => false);
            } else {
              Fluttertoast.showToast(msg: res);
            }
          }
        },
        child: Text(
          'signUp',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 180,
                    child: Text('enbla app'),
                  ),
                  SizedBox(height: 45),
                  firstname,
                  SizedBox(height: 45),
                  lastname,
                  SizedBox(height: 20),
                  phoneNumber,
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  emailField,
                  SizedBox(height: 20),
                  passwordField,
                  SizedBox(height: 20),
                  conformPassword,
                  SizedBox(height: 20),
                  address,
                  SizedBox(height: 15),
                  signupButton,
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  // void signup(String email, String password) async {
  //   if (_formkey.currentState!.validate()) {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     postDetailsToFirestore(userCredential);
  //     //   .then((value) => {postDetailsToFirestore()})
  //     //   .catchError((e) {
  //     // Fluttertoast.showToast(msg: e!.message);
  //     // });
  //   }
  // }

  // postDetailsToFirestore(UserCredential userCredential) async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;

  //   model.User Usermodel = model.User();

  //   Usermodel.email = user!.email;
  //   Usermodel.uid = userCredential.user!.uid;
  //   Usermodel.firstname = firstnameEditingController.text;
  //   Usermodel.lastname = lastnameEditingController.text;

  //   Usermodel.phonenumber = phoneNumberEditingController.text;
  //   Usermodel.address = addressController.text;

  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(Usermodel.toJson());
  //   Fluttertoast.showToast(msg: 'account created successfully');

  //   Navigator.pushAndRemoveUntil(
  //       (context),
  //       MaterialPageRoute(builder: (context) => LoginPage()),
  //       (router) => false);
  // }
}
