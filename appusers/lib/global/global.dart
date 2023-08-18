import 'package:appusers/model/direction_details_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;
UserModel? userModelCurrentinfo;

String cloudMessagingServerToken =
    "key=AAAAbrgkWT0:APA91bEemBaqPrLbErg-UsALK-xylecccOBWxO9EhTOLIAUNrlpxDZL9ELgoYBZDy0YgBCK11Jj3M67XbQbjBEJxVjul-R8T38pdrTqB6GUsRNkpGmHLyDbjvpW4T7kykiiC_jV504BW";
List driversList = [];
DirectionDetailsInfo? tripDirectionDetailsInfo;
String userDropOffAddress = "";
String driverCarDetails = "";
String driverName = "";
String driverPhone = "";

double countRatingStars = 0.0;
String titleStartsRating = "";
