import 'package:appusers/widgets/place_prediction_tile.dart';
import 'package:flutter/material.dart';

import '../global/map_key.dart';
import '../model/prediction_places.dart';
import 'Assistant/request_Assistant.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);
  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  //List of predicted places
  List<PredictedPlaces> placesPredictedList = [];
  //function for autocomplete search
  findPlaceAutoCompleteSearch(String inputText) async {
    if (inputText.length > 1) {
      String urlAutoCompleteSearch =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapkey&components=country:UG";

      var responseAutoCompleteSearch =
          await RequestAssitant.receiveRequest(urlAutoCompleteSearch);

      // if (responseAutoCompleteSearch == "Error ocurred. Failed. No Response.") {
      //   return;
      // }
      if (responseAutoCompleteSearch == "Error ocurred. Failed. No Response.") {
        return;
      }

      if (responseAutoCompleteSearch["status"] == "OK") {
        var placePredictions = responseAutoCompleteSearch["predictions"];

        var placePredictionsList = (placePredictions as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData))
            .toList();
        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //color boolean
    bool darktheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    ////
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: darktheme ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor:
              darktheme ? Colors.amber.shade400 : Colors.greenAccent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: darktheme ? Colors.black : Colors.white,
            ),
          ),
          title: Text(
            "Set dropoff location",
            style: TextStyle(color: darktheme ? Colors.black : Colors.white),
          ),
          elevation: 0.0,
        ),

        //body
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: darktheme ? Colors.amber.shade400 : Colors.greenAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white54,
                    blurRadius: 8,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.adjust_sharp,
                            color: darktheme ? Colors.black : Colors.white),

                        //sized box
                        SizedBox(
                          height: 18.0,
                        ),

                        //expanded widget

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                              onChanged: (value) {
                                //automatically search
                                findPlaceAutoCompleteSearch(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Location',
                                fillColor:
                                    darktheme ? Colors.black : Colors.white54,
                                filled: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 11,
                                  top: 8,
                                  bottom: 8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            //display place prediction results
            (placesPredictedList.length > 0)
                ? Expanded(
                    child: ListView.separated(
                      itemCount: placesPredictedList.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PlacePredictionDesign(
                          predictedPlaces: placesPredictedList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 0,
                          color:
                              darktheme ? Colors.amber.shade400 : Colors.blue,
                          thickness: 0,
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
