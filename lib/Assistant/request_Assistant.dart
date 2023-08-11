import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssitant {
  static Future<dynamic> receiveRequest(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try {
      if (httpResponse.statusCode == 200) //succesful

      {
        String responsedata = httpResponse.body;
        var decodeResponseData = jsonDecode(responsedata);

        return decodeResponseData;
      } else {
        return "Error ocurred, Failed, No Response";
      }
    } catch (exp) {
      return "Error ocurred, Failed, No Response";
    }
  }
}
