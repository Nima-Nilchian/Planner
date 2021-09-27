import 'dart:core';
import 'package:daily_excersises/shared_preferences/calendar_preferences.dart';
import 'package:intl/intl.dart';
import 'package:daily_excersises/model/Event.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {

  late Rx<DateTime> selectedDay;

  late Rx<DateTime> focusedDay;

  var calendarFormat = CalendarFormat.month.obs;

  bool timeAdded = false;

  static RxMap<String, RxList<Event>> allEvents = Map<String, RxList<Event>>()
      .obs;


  var _calPref = CalendarPreferences();

  List<Event> getEventsOfDay(day) {
    return allEvents[DateFormat.yMd().format(day)] ?? [];
  }

  @override
  void onInit() async {
    super.onInit();

    // making observable
    selectedDay = DateTime
        .now()
        .obs;
    focusedDay = DateTime
        .now()
        .obs;

    await _calPref.fetchEvents();
  }

  @override
  void onClose() {
    super.onClose();

    _calPref.saveEvents();
  }

}