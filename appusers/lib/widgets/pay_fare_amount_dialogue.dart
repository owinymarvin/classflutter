import 'package:appusers/welcome_screen/welcome.dart';
import 'package:flutter/material.dart';

class PayFareAmountDialogue extends StatefulWidget {
  double? fareAmount;
  PayFareAmountDialogue({this.fareAmount});
  @override
  State<PayFareAmountDialogue> createState() => _PayFareAmountDialogueState();
}

class _PayFareAmountDialogueState extends State<PayFareAmountDialogue> {
  @override
  Widget build(BuildContext context) {
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: darktheme ? Colors.black : Colors.greenAccent,
        ),
        child: Column(
          children: [
            Text(
              "Fare Amount".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darktheme ? Colors.amber.shade400 : Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
              color: darktheme ? Colors.amber.shade400 : Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "UGX" + widget.fareAmount.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darktheme ? Colors.amber.shade400 : Colors.white,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "This is the total tow service trip charge",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darktheme ? Colors.amber.shade400 : Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: darktheme ? Colors.amber.shade400 : Colors.white,
                ),
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 10000), () {
                    Navigator.pop(context, "Cash Paid");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => WelcomeScreen()));
                  });
                },
                child: Row(
                  children: [
                    Text(
                      "Pay Cash",
                      style: TextStyle(
                        fontSize: 20,
                        color: darktheme ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "UGX" + widget.fareAmount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: darktheme ? Colors.black : Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
