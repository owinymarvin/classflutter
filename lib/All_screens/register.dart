import 'package:appusers/All_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import '../widget/progressdialog.dart';
import 'homepage.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage("assets/images/tow2.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                " Register as a User",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: txtName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: txtEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: txtPhone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: txtPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (txtName.text.length < 4) {
                          displayMessage(
                              context, 'Name cannot be less than 3 Character');
                        } else if (!txtEmail.text.contains('@')) {
                          displayMessage(context, 'Email Address is not Valid');
                        } else if (txtPhone.text.isEmpty) {
                          displayMessage(context, 'Phone Number is mandatory');
                        } else if (txtPassword.text.length < 6) {
                          displayMessage(context,
                              'Password must be at least 6 Characters');
                        } else {
                          registerNewUser(context);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent,
                        onPrimary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.idScreen, (route) => false);
                },
                child: Text(
                  "Already have an Account? Login Here.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//authenticate a user
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //registering a user
  void registerNewUser(BuildContext context) async {
    //prgress dialogue here
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering user...",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: txtEmail.text, password: txtPassword.text)
            // ignore: body_might_complete_normally_catch_error
            .catchError((err) {
      //pop off the progress indicator
      Navigator.pop(context);

      // displayMessage("Error: $err" as BuildContext, context as String);
      displayMessage("Error: $err" as BuildContext, context as String);
    }))
        .user;

    // ignore: unnecessary_null_comparison
    if (firebaseUser != null) {
      //save user info to firebase database
      Map userDataMap = {
        "name": txtName.text.trim(),
        "email": txtEmail.text.trim(),
        "phone": txtPhone.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayMessage(context, "Congratulations, Your Account has be created");
      Navigator.pushNamedAndRemoveUntil(
          context, MyHomePage.idScreen, (route) => false);
    } else {
      //pop off the progress indicator
      Navigator.pop(context);
      displayMessage(context, "User Account has not been created");
    }
  }
}

displayMessage(BuildContext context, String message) {
  Fluttertoast.showToast(msg: message);
}
