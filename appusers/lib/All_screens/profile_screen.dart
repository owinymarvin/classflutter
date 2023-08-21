import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();

  //add to database
  DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users');

  Future<void> showUserNameDialogueAlert(BuildContext context, String name) {
    nameTextEditingController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("update"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameTextEditingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
              TextButton(
                onPressed: () {
                  userRef.child(firebaseAuth.currentUser!.uid).update({
                    "name": nameTextEditingController.text.trim(),
                  }).then((value) {
                    nameTextEditingController.clear();
                    Fluttertoast.showToast(
                        msg:
                            "changes made successfull.\n reload to see changes");
                  }).catchError((errorMessage) {
                    Fluttertoast.showToast(
                        msg: "Error occured.\n $errorMessage");
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ],
          );
        });
  }

  ///phone
  Future<void> showUserPhoneDialogueAlert(BuildContext context, String phone) {
    phoneTextEditingController.text = phone;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("update"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: phoneTextEditingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
              TextButton(
                onPressed: () {
                  userRef.child(firebaseAuth.currentUser!.uid).update({
                    "phone": phoneTextEditingController.text.trim(),
                  }).then((value) {
                    phoneTextEditingController.clear();
                    Fluttertoast.showToast(
                        msg:
                            "changes made successfull.\n reload to see changes");
                  }).catchError((errorMessage) {
                    Fluttertoast.showToast(
                        msg: "Error occured.\n $errorMessage");
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ],
          );
        });
  }

  //address

  Future<void> showUserAddressDialogueAlert(
      BuildContext context, String address) {
    addressTextEditingController.text = address;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("update"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: addressTextEditingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
              TextButton(
                onPressed: () {
                  userRef.child(firebaseAuth.currentUser!.uid).update({
                    "address": addressTextEditingController.text.trim(),
                  }).then((value) {
                    addressTextEditingController.clear();
                    Fluttertoast.showToast(
                        msg:
                            "changes made successfull.\n reload to see changes");
                  }).catchError((errorMessage) {
                    Fluttertoast.showToast(
                        msg: "Error occured.\n $errorMessage");
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.greenAccent,
            ),
          ),
          title: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_2_rounded,
                    color: Colors.white,
                  ),
                ),

                //sized box
                SizedBox(
                  height: 30,
                ),
                //username
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userModelCurrentinfo != null
                          ? "${userModelCurrentinfo!.name!}"
                          : "Default Username",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //icon button
                    IconButton(
                      onPressed: () {
                        //////////////
                        showUserNameDialogueAlert(
                            context, userModelCurrentinfo!.name!);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),

                //divider
                Divider(
                  thickness: 1,
                ),

                //phone
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userModelCurrentinfo != null
                          ? "${userModelCurrentinfo!.phone!}"
                          : "Default Phone Number",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //icon button
                    IconButton(
                      onPressed: () {
                        /////////////
                        showUserPhoneDialogueAlert(
                            context, userModelCurrentinfo!.phone!);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),

                //email
                Divider(
                  thickness: 1,
                ),

                //address
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userModelCurrentinfo != null
                          ? "${userModelCurrentinfo!.address!}"
                          : "Default Current Info",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //icon button
                    IconButton(
                      onPressed: () {
                        /////////////
                        showUserAddressDialogueAlert(
                            context, userModelCurrentinfo!.address!);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                ),

                //email
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userModelCurrentinfo != null
                          ? "${userModelCurrentinfo!.email!}"
                          : "Default Email",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
