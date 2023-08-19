import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
// import 'package:provider/provider.dart';
import 'package:towdrivers/global/global.dart';
// import 'package:towdrivers/info_handler/app_info.dart';

class RatingTabPage extends StatefulWidget {
  @override
  State<RatingTabPage> createState() => _RatingTabPageState();
}

class _RatingTabPageState extends State<RatingTabPage> {
  double ratingsNumber = 0;

  //increament
  @override
  void initState() {
    super.initState();
  }

  // getRtingNumber() {
  //   setState(() {
  //     ratingsNumber = double.parse(
  //         Provider.of<AppInfo>(context, listen: false).driverAverageRatings);
  //   });
  // }

  setupRatingsTitle() {
    if (ratingsNumber >= 0) {
      setState(() {
        titleStarRating = "veryBad";
      });
    }
    if (ratingsNumber >= 1) {
      setState(() {
        titleStarRating = "Bad";
      });
    }
    if (ratingsNumber >= 2) {
      setState(() {
        titleStarRating = "Good";
      });
    }
    if (ratingsNumber >= 3) {
      setState(() {
        titleStarRating = "VeryGood";
      });
    }

    if (ratingsNumber >= 4) {
      setState(() {
        titleStarRating = "Excellent";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkthem =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darkthem ? Colors.black : Colors.greenAccent,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: darkthem ? Colors.grey : Colors.white60,
        child: Container(
          margin: EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(
            color: darkthem ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 22.0,
              ),
              Text(
                "Your Ratings",
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Signatra',
                  color: darkthem ? Colors.grey.shade400 : Colors.greenAccent,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SmoothStarRating(
                rating: ratingsNumber,
                allowHalfRating: true,
                starCount: 5,
                color: darkthem ? Colors.grey.shade400 : Colors.white,
                borderColor:
                    darkthem ? Colors.grey.shade400 : Colors.greenAccent,
                size: 46,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                titleStarRating,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  backgroundColor:
                      darkthem ? Colors.grey.shade400 : Colors.greenAccent,
                ),
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
