import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstpro/features/profile_text_box.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all user
  final userscollection = FirebaseFirestore.instance.collection("Users");

  //edit field function
  Future<void> editfield(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit " + field,
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
//lets give the values tp our new values
        actions: [
          //cancel button
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),

          //save button

          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    //updating in the firestore
    if (newValue.trim().length > 0) {
      //only update if there is something in the textfield
      await userscollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.grey[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),
                //profile pic
                Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(height: 10),

                //user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[800]),
                ),

                const SizedBox(height: 50),
                //user details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My details",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                //username

                ProfileTextBox(
                  text: userData['username'],
                  sectionName: 'username',
                  onPressed: () => editfield('username'),
                ),

                //bio

                ProfileTextBox(
                  text: userData['bio'],
                  sectionName: 'bio',
                  onPressed: () => editfield('bio'),
                ),

                const SizedBox(height: 50),

                //wallet

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My Wallet",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
//return circular progress indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
