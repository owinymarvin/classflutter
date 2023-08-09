import 'package:appusers/widget/progressdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import '../main.dart';
import 'homepage.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  static const String idScreen = "login";

  @override
  Widget build(BuildContext context) {
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPassword = TextEditingController();

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
                " Login as a User",
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
                        if (!txtEmail.text.contains('@')) {
                          displayMessage(context, 'Email Address is not Valid');
                        } else if (txtPassword.text.isEmpty) {
                          displayMessage(context, 'Password is mandatory');
                        } else {
                          loginUser(context, txtEmail.text, txtPassword.text);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegisterPage.idScreen, (route) => false);
                },
                child: Text(
                  "Don't have an Account? Register Here.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginUser(BuildContext context, String email, String password) async {
    //prgress dialogue here
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Logging in user...",
          );
        });
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Successful login, navigate to main screen
        Navigator.pushNamedAndRemoveUntil(
            context, MyHomePage.idScreen, (route) => false);

        displayMessage(context, "Congratulations, You are logged in");
      } else {
        //pop off the progress indicator
        Navigator.pop(context);
        displayMessage(context, "Error: User login failed");
      }
    } catch (error) {
      //pop off progress indicator
      Navigator.pop(context);
      displayMessage(context, "Error: $error");
    }
  }

  // You should define the displayMessage function here or import it from elsewhere

  displayMessage(BuildContext context, String message) {
    Fluttertoast.showToast(msg: message);
  }
}
