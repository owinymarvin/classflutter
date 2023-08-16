import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:towdrivers/All_screens/register.dart';
import 'package:towdrivers/welcome_screen/welcome.dart';

import '../global/global.dart';
import 'forgot_password.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controllers
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  //global key
  final _formkey = GlobalKey<FormState>();

//password visible class
  bool _passwordvisible = false;

  void _submit() async {
    //validate all the form field
    //with form controllers

    if (_formkey.currentState!.validate()) {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailTextEditingController.text.trim(),
              password: passwordTextEditingController.text.trim())
          .then((auth) async {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child("drivers");
        userRef.child(firebaseAuth.currentUser!.uid).once().then((value) async {
          final snap = value.snapshot;
          if (snap.value != null) {
            currentUser = auth.user;

            await Fluttertoast.showToast(msg: "Logged in successfully");
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => MyHomePage()));
          } else {
            await Fluttertoast.showToast(
                msg: "No record exists with this email");
            firebaseAuth.signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => WelcomeScreen()));
          }
        });

        // await Fluttertoast.showToast(msg: "Logged in successfully");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (c) => MyHomePage()));
      }).catchError((ErrorMessage) {
        Fluttertoast.showToast(msg: "Error occured: \n $ErrorMessage ");
      });
    }
    //else
    else {
      Fluttertoast.showToast(msg: "Not all fields are valid");
    }
  }

  @override
  Widget build(BuildContext context) {
// for theme  colors
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      //scaffold here
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                // Image.asset(darktheme
                //     ? 'assets/images/tow2.png'
                //     : 'assets/images/tow2.png'),
                SvgPicture.asset(
                  darktheme
                      ? 'assets/images/tow1.svg'
                      : 'assets/images/tow1.svg',
                  semanticsLabel: 'Car towing image',
                  width: 200,
                  color: Colors.greenAccent,
                ),
                // Image.asset(darktheme
                //     ? 'assets/images/tow2.png'
                //     : 'assets/images/tow2.png'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sign in as a Tow driver',
                  style: TextStyle(
                    color: darktheme ? Colors.amberAccent : Colors.greenAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 54),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        //form key
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //email
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: darktheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: darktheme
                                      ? Colors.amber.shade400
                                      : Colors.grey,
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Email can\t be empty';
                                }
                                //email validator
                                if (EmailValidator.validate(text) == true) {
                                  return null;
                                }
                                if (text.length < 2) {
                                  return 'Please enter a valid Email';
                                }
                                if (text.length > 99) {
                                  return 'Email can\t be more than 50';
                                }
                                //return null
                                return null;
                              },
                              onChanged: (text) => setState(() {
                                emailTextEditingController.text = text;
                              }),
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            //Password field

                            TextFormField(
                              obscureText: !_passwordvisible,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: darktheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: darktheme
                                      ? Colors.amber.shade400
                                      : Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordvisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: darktheme
                                        ? Colors.amber.shade400
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    //update state by toggleling
                                    setState(() {
                                      _passwordvisible = !_passwordvisible;
                                    });
                                  },
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Password can\t be empty';
                                }
                                if (text.length < 6) {
                                  return 'Please enter a valid Password';
                                }
                                if (text.length > 50) {
                                  return 'Password can\t be more than 50';
                                }
                                return null;
                              },
                              onChanged: (text) => setState(() {
                                passwordTextEditingController.text = text;
                              }),
                            ),

                            //sized box
                            SizedBox(
                              height: 20,
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: darktheme
                                    ? Colors.amber.shade400
                                    : Colors.greenAccent,
                                onPrimary:
                                    darktheme ? Colors.black : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                _submit();
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),

                            //sized box
                            SizedBox(
                              height: 20,
                            ),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) =>
                                            ForgotPasswordScreen()));
                              },
                              child: Text(
                                "Forgot password",
                                style: TextStyle(
                                  color: darktheme
                                      ? Colors.amber.shade400
                                      : Colors.blue,
                                ),
                              ),
                            ),

                            //sized box

                            SizedBox(
                              height: 20,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Dont have an account?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => RegisterScreen()));
                                  },
                                  child: Text(
                                    "Create one",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: darktheme
                                          ? Colors.amber.shade400
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //
    );
  }
}
