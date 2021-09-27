import 'package:daily_excersises/controller/calendar_controller.dart';
import 'package:daily_excersises/model/Event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class CalendarPreferences {



  Future saveEvents() async {
    var _pref = await SharedPreferences.getInstance();

    var allEvents = CalendarController.allEvents.map((key, value) =>
        MapEntry(key,
            value.map((element) => jsonEncode(element.toMap())).toList()));

    _pref.setString("allEvents", jsonEncode(allEvents));
  }

  Future fetchEvents() async {
    var _pref = await SharedPreferences.getInstance();

    var _allEvents = _pref.getString("allEvents") ?? "null";
    Map allEventsMap = jsonDecode(_allEvents);

    Map<String,RxList<Event>> a = allEventsMap.map((key, value) {
      List<dynamic> lst = value.map((e) => Event.fromMap(jsonDecode(e))).toList();
      return MapEntry(key, lst.cast<Event>().obs);
    }
    );

    CalendarController.allEvents.value = RxMap.from(a.obs);

  }
}
