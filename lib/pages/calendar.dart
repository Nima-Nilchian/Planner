import 'package:daily_excersises/controller/calendar_controller.dart';
import 'package:daily_excersises/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Calendar extends StatelessWidget {
  final calctrl = Get.put(CalendarController());

  final txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: Obx(
        () {
          return SingleChildScrollView(
            child: Column(children: [
              TableCalendar(
                lastDay: DateTime(2100),
                firstDay: DateTime(1980),
                focusedDay: calctrl.focusedDay.value,
                startingDayOfWeek: StartingDayOfWeek.saturday,
                calendarFormat: calctrl.calendarFormat.value,
                onFormatChanged: (format) =>
                    calctrl.calendarFormat.value = format,
                onDaySelected: (selectDay, focusDay) {
                  calctrl.focusedDay.value = focusDay;
                  calctrl.selectedDay.value = selectDay;
                },
                selectedDayPredicate: (day) =>
                    isSameDay(calctrl.focusedDay.value, day),
                eventLoader: calctrl.getEventsOfDay,
                headerStyle: HeaderStyle(
                    formatButtonShowsNext: false,
                    titleCentered: true,
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),

              /// Showing Events
              ...calctrl.getEventsOfDay(calctrl.selectedDay.value).map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Dismissible(
                        key:
                            Key(e.title.value + e.time.value.minute.toString()),
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onDismissed: (_) {
                          CalendarController.allEvents[DateFormat.yMd()
                                  .format(calctrl.selectedDay.value)]!
                              .remove(e);

                          Get.snackbar("Done", "Event deleted",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 1));
                        },
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text(e.title.value),
                              subtitle: e.timeAdded.value
                                  ? Text(e.timeFormatted.value)
                                  : Text(""),
                              onTap: () => editEvent(e, context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
            ]),
          );
        },
      ),
      floatingActionButton: FloatingButton(txt: txt, calctrl: calctrl),
    );
  }

  /// Editing Time of Event
  var _time = TimeOfDay(hour: 18, minute: 20);
  bool addedNewTime = false;

  void editEvent(Event e, context) {
    txt.text = e.title.value;
    _time = e.time.value;

    Get.dialog(
      SingleChildScrollView(
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          title: Text("Edit Event"),
          content: TextField(
            controller: txt,
            decoration: InputDecoration(hintText: "Enter Event Title"),
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: [
            TextButton(
              child: Text("Add Time"),
              onPressed: () => _selectTime(context),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                txt.clear();
              },
              child: Text("Cancel"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text("Done"),
              onPressed: () {
                if (txt.text.isEmpty)
                  return;
                else {
                  var event = CalendarController.allEvents[
                          DateFormat.yMd().format(calctrl.selectedDay.value)]!
                      .firstWhere((element) => element == e);

                  event.title.value = txt.text;

                  if (addedNewTime) {
                    event.timeAdded.value = addedNewTime;
                    event.time.value = _time;
                    event.timeFormatted.value = _time.format(context);
                  }
                }
                txt.clear();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectTime(context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      helpText: "Add Event Time",
      initialEntryMode: TimePickerEntryMode.dial,
    );

    addedNewTime = true;

    if (newTime != null) {
      _time = newTime;
    }
  }
}

/// For Adding Time Event
class FloatingButton extends StatelessWidget {
  FloatingButton({
    required this.txt,
    required this.calctrl,
  });

  final TextEditingController txt;
  final CalendarController calctrl;

  TimeOfDay time = TimeOfDay(hour: 18, minute: 20);

  bool _timeAdded = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        label: Text("Add Event"),
        icon: Icon(Icons.add),
        onPressed: () => addEvent(context));
  }

  void addEvent(context) {
    Get.dialog(
      SingleChildScrollView(
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          title: Text("Add Event"),
          content: TextField(
            controller: txt,
            decoration: InputDecoration(hintText: "Enter Event Title"),
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: [
            OutlinedButton(
              child: Text("Add Time"),
              onPressed: () => _selectTime(context),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                txt.clear();
              },
              child: Text("Cancel"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text("Done"),
              onPressed: () {
                if (txt.text.isEmpty)
                  return;
                else if (CalendarController.allEvents[
                        DateFormat.yMd().format(calctrl.selectedDay.value)] !=
                    null)
                  CalendarController.allEvents[
                          DateFormat.yMd().format(calctrl.selectedDay.value)]!
                      .add(Event(
                          txt.text, time, _timeAdded, time.format(context)));
                else {
                  var lst = [
                    Event(txt.text, time, _timeAdded, time.format(context))
                  ].obs;
                  CalendarController.allEvents[
                      DateFormat.yMd().format(calctrl.selectedDay.value)] = lst;
                }
                txt.clear();
                Get.back();
                _timeAdded = false;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectTime(context) async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: time,
        helpText: "Add Event Time",
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    _timeAdded = true;

    if (newTime != null) {
      time = newTime;
    }
  }
}
