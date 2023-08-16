// import 'dart:math';

// import 'package:email_validator/email_validator.dart';
import 'package:appusers/All_screens/forgot_password.dart';
import 'package:appusers/All_screens/homepage.dart';
import 'package:appusers/All_screens/login.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../global/global.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmTextEditingController = TextEditingController();

  bool _passwordvisible = false;

  //global key
  final _formkey = GlobalKey<FormState>();

  //submit function
  void _submit() async {
    //validate all the form field
    //with form controllers

    if (_formkey.currentState!.validate()) {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailTextEditingController.text.trim(),
              password: passwordTextEditingController.text.trim())
          .then((auth) async {
        currentUser = auth.user;

        if (currentUser != null) {
          //create map for database
          Map userMap = {
            "id": currentUser!.uid,
            "name": nameTextEditingController.text.trim(),
            "email": emailTextEditingController.text.trim(),
            "address": addressTextEditingController.text.trim(),
            "phone": phoneTextEditingController.text.trim(),
          };
          //add to database
          DatabaseReference userRef =
              FirebaseDatabase.instance.ref().child("users");
          userRef.child(currentUser!.uid).set(userMap);
        }
        await Fluttertoast.showToast(msg: "Registered successfully");
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MyHomePage()));
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
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Register for Tow services',
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
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Name',
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
                                  return 'Name can\t be empty';
                                }
                                if (text.length < 2) {
                                  return 'Please enter a valid name';
                                }
                                if (text.length > 50) {
                                  return 'Name can\t be more than 50';
                                }
                                //return null
                                return null;
                              },
                              onChanged: (text) => setState(() {
                                nameTextEditingController.text = text;
                              }),
                            ),
                            //sized box
                            SizedBox(
                              height: 20,
                            ),

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

                            //sized box
                            SizedBox(
                              height: 20,
                            ),
                            //phone field
                            IntlPhoneField(
                              showCountryFlag: false,
                              dropdownIcon: Icon(
                                Icons.arrow_drop_down,
                                color: darktheme
                                    ? Colors.amber.shade400
                                    : Colors.grey,
                              ),

                              //decoration
                              decoration: InputDecoration(
                                hintText: 'Phone',
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
                                // prefixIcon: Icon(
                                //   Icons.person,
                                //   color: darktheme
                                //       ? Colors.amber.shade400
                                //       : Colors.grey,
                                // ),
                              ),
                              initialCountryCode: 'UG',
                              onChanged: (text) => setState(() {
                                phoneTextEditingController.text =
                                    text.completeNumber;
                              }),
                            ),

                            //address

                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Address',
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
                                  return 'Address can\t be empty';
                                }
                                if (text.length < 2) {
                                  return 'Please enter a valid Address';
                                }
                                if (text.length > 99) {
                                  return 'Address can\t be more than 50';
                                }
                                //return null
                                return null;
                              },
                              onChanged: (text) => setState(() {
                                addressTextEditingController.text = text;
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

                            //confirm password
                            TextFormField(
                              obscureText: !_passwordvisible,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: 'ConfirmPassword',
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
                                  return 'ConfirmPassword can\t be empty';
                                }
                                if (text !=
                                    passwordTextEditingController.text) {
                                  return "Password donot match";
                                }
                                if (text.length < 6) {
                                  return 'Please enter a valid confirm Password';
                                }
                                if (text.length > 50) {
                                  return ' confirmPassword can\t be more than 50';
                                }
                                return null;
                              },
                              onChanged: (text) => setState(() {
                                confirmTextEditingController.text = text;
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
                                "Register",
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
                                  "Already have an account?",
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
                                            builder: (c) => LoginScreen()));
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: darktheme
                                          ? Colors.amber.shade400
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
