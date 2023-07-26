import 'dart:ui'; // Import the dart:ui library for Color class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/text_fields/my_button.dart';
import 'package:firstpro/text_fields/square_frame.dart';
import 'package:firstpro/text_fields/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Method to sign user up
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

    // Try creating a user
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // Show error message - passwords don't match
        showWrongPasswordMessage();
      }
    } on FirebaseAuthException catch (e) {
      // Handling signup error
      if (e.code == 'email-already-in-use') {
        showEmailInUseMessage();
      } else if (e.code == 'weak-password') {
        showWeakPasswordMessage();
      } else {
        showGenericErrorMessage();
      }
    }

    // Remove the loading circle
    Navigator.pop(context);
  }

  // Show popup for email already in use
  void showEmailInUseMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Email already in use'),
        );
      },
    );
  }

  // Show popup for weak password
  void showWeakPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Weak password'),
        );
      },
    );
  }

  // Show popup for generic error
  void showGenericErrorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('An error occurred'),
        );
      },
    );
  }

  // Method to show error message - passwords don't match
  void showWrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Passwords do not match'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors
                  .blueGrey, // You can specify multiple colors for the gradient
              Colors.white38,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //basically empty space
                  const SizedBox(height: 25),

                  //logo
                  const Icon(
                    Icons.lock,
                    size: 60,
                  ),

                  const SizedBox(height: 25),
                  Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
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

                  const SizedBox(
                      height: 30), //sized box for "or continue with "

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
      ),
    );
  }
}