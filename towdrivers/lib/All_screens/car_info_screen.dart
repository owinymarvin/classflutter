import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:towdrivers/welcome_screen/welcome.dart';

import '../global/global.dart';
import 'forgot_password.dart';
import 'login.dart';

class TowCarInfoScreen extends StatefulWidget {
  const TowCarInfoScreen({super.key});

  @override
  State<TowCarInfoScreen> createState() => _TowCarInfoScreenState();
}

class _TowCarInfoScreenState extends State<TowCarInfoScreen> {
  final towCarModelTextEditingContoller = TextEditingController();
  final towCarNumberTextEditingContoller = TextEditingController();
  final towCarColorTextEditingContoller = TextEditingController();
//CAR type
  List<String> towCarTypes = ["Flatbed", "Hookandchain", "Wheellift"];
  String? selectedTowCarType;
  final _formkey = GlobalKey<FormState>();

  //submit function
  _submit() {
    if (_formkey.currentState!.validate()) {
      Map driverCarInfoMap = {
        "car_model": towCarModelTextEditingContoller.text.trim(),
        "car_number": towCarNumberTextEditingContoller.text.trim(),
        "car_color": towCarColorTextEditingContoller.text.trim(),
      };

      //database
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child("drivers");
      userRef
          .child(currentUser!.uid)
          .child("car_details")
          .set(driverCarInfoMap);

      Fluttertoast.showToast(msg: "Car details saved successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => WelcomeScreen()));
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
                  height: 80,
                ),
                // Image.asset(darktheme ? 'image/city.png' : 'image/city.jpg'),
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
                  "Add Car Details",
                  style: TextStyle(
                    color:
                        darktheme ? Colors.amber.shade400 : Colors.greenAccent,
                  ),
                ),

                ////////////
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
                                hintText: "Tow Model",
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
                                towCarModelTextEditingContoller.text = text;
                              }),
                            ),
                            //sized box
                            SizedBox(
                              height: 20,
                            ),

                            //Tow car number
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: "Tow Number",
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
                                towCarNumberTextEditingContoller.text = text;
                              }),
                            ),
                            //sized box
                            SizedBox(
                              height: 20,
                            ),

                            //Tow car
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              decoration: InputDecoration(
                                hintText: "Tow Color",
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
                                towCarColorTextEditingContoller.text = text;
                              }),
                            ),
                            //sized box
                            SizedBox(
                              height: 20,
                            ),

                            //drop down button
                            DropdownButtonFormField(
                                decoration: InputDecoration(
                                  hintText: "Please chose tow car type",
                                  prefixIcon: Icon(
                                    Icons.car_crash_outlined,
                                    color: darktheme
                                        ? Colors.amber.shade400
                                        : Colors.grey,
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
                                ),
                                items: towCarTypes.map((car) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      car,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    //value car
                                    value: car,
                                  );
                                }).toList(),
                                onChanged: (newvalue) {
                                  setState(() {
                                    //slected car
                                    selectedTowCarType = newvalue.toString();
                                  });
                                }),

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
                                "Confirm",
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ///////////
              ],
            )
          ],
        ),
      ),
    );
  }
}
