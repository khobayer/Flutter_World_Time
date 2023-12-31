import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; // location name for thr url
  String? time; // the time in that location
  String? flag; // url to an asset flag icon
  String? url; // loaction url for api endpoint
  bool? isDayTime; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properrtise from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 17 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      // ignore: avoid_print
      print('Found some error: $e');
      time = 'Could Not Get Time & Date';
    }
  }
}
