import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; //location name for ui
  String time = ""; //time in the location
  String flag; //url to asset flag icon
  String url; //location url for api end point
  late bool isDaytime;//true or false if day time or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(
          Uri.https('worldtimeapi.org', 'api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      DateTime now = DateTime.parse(dateTime.substring(0, 26));

      isDaytime = now.hour > 6 &&  now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }catch(e){
      print('Caught Exception - $e');
      time = 'Couldnt fetch time! :(';
    }
  }
}