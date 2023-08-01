import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/features/my_button.dart';
import 'package:firstpro/features/square_frame.dart';
import 'package:firstpro/features/my_textfield.dart';
// import 'signup_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up
  void signUserUp() async {
    // Show a progress circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      // Remove the loading circle
      Navigator.pop(context);
      //display this to a user
      displayMessage("Passwords dont match!!");
      return;
    }

    // Try creating a user
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      /*after creating a user create a new document in the cloud firestore
      called Users*/
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email!)
          .set({
        'username': emailController.text.split('@')[0], //username
        'bio': 'empty bio..' //initial bio info
        //note: can add more fields here
      });

      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Remove the loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage(e.code);
    }
  }

  // Show popup for email already in use
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        //makes UI avoid the notch area
        child: Center(
          //center the icon
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //basically empty space
                const SizedBox(height: 25),

                //logo
                const Icon(
                  Icons.create_outlined,
                  size: 60,
                ),

                const SizedBox(height: 25),
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 25), //sized box for email
                //email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email:',
                  obscureText: false,
                ),

                //password
                const SizedBox(height: 10), //sized box for password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10), //sized box for confirm password
                //Confirm password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25), //sized box for signup button
                MyButton(
                  text: 'Sign Up',
                  ontap: signUserUp, //call the method signUpUser
                ),

                const SizedBox(height: 30), //sized box for "or continue with "

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30), // space this too

                //apple and google signin buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //for google
                    SquareFrame(imagepath: 'lib/images/google.png'),

                    SizedBox(width: 25), // to space the buttons

                    //for apple
                    SquareFrame(imagepath: 'lib/images/apple.png'),
                  ],
                ),

                const SizedBox(height: 30), // space this too
                //already a member? login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4), // space this too

                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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
