import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? ontap; //sign in function for button
  final String text;
  const MyButton({
    super.key,
    required this.ontap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(25), //setting the padding
        margin:
            const EdgeInsets.symmetric(horizontal: 25), //setting the margins
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8), //border radius
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
