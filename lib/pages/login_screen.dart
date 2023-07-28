import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/text_fields/my_button.dart';
import 'package:firstpro/text_fields/square_frame.dart';
import 'package:firstpro/text_fields/my_textfield.dart';
// import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text editing controllers
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  //sign user in
  void signUserIn() async {
    //progress circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
//signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      ); //handling sign in error

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      //error message wrong email or password function
      wrongErrorMessage(e.code);
    }
  }

  //wrong email or password popup message to be displayed
  void wrongErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Center(
            child: Text(
              message,
            ),
          ),
        );
      },
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
                const SizedBox(height: 30),

                //logo
                const Icon(
                  Icons.login_sharp,
                  size: 80,
                ),

                const SizedBox(height: 30),
                Text(
                  'welcome',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 25), //sized box for username
                //username
                MyTextField(
                  controller: emailcontroller,
                  hintText: 'username:',
                  obscureText: false,
                ),

                //password
                const SizedBox(height: 10), //sized box for password
                MyTextField(
                  controller: passwordcontroller,
                  hintText: 'password',
                  obscureText: true,
                ),

                const SizedBox(height: 10), //sized box for forgotpass
                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'forgot password',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25), //sized box for signin button
                MyButton(
                  text: 'Sign In',
                  ontap: signUserIn, //call the method signUserIn
                ),

                const SizedBox(height: 40), //sized box for "or continue with "

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
                //not a member? register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4), // space this too

                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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
