import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import 'login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//email controller for reseting password
  final emailTextEditingController = TextEditingController();

  //global key
  final _formkey = GlobalKey<FormState>();

  //reset password code or function
  void _submit() {
    firebaseAuth
        .sendPasswordResetEmail(email: emailTextEditingController.text.trim())
        .then((value) {
      Fluttertoast.showToast(
          msg: "Please check your email to reset your password");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Error occured \n ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    //for dark and light theme
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
                  'Reset Password?',
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
                                "Reset",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),

                            //sized box
                            SizedBox(
                              height: 20,
                            ),

                            GestureDetector(
                              onTap: () {},
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
                                    "Login",
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
