import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Event {

  late RxString title = "".obs;

  late Rx<TimeOfDay> time = TimeOfDay(hour: 0, minute: 0).obs;

  late RxString timeFormatted = "".obs;

  RxBool timeAdded = false.obs;

  Event(title,time, bool timeAdded,timeFormatted){
    this.title.value = title;
    this.time.value = time;
    this.timeAdded.value = timeAdded;
    if(timeAdded)
      this.timeFormatted.value = timeFormatted;
  }

  Map toMap(){
    return{
      "title" : this.title.value,
      "time" : this.timeFormatted.value,
      "timeAdded": this.timeAdded.value
    };
  }

  Event.fromMap(Map item) {
    this.title.value = item["title"];
    this.timeFormatted.value = item["time"];
    this.timeAdded.value = item["timeAdded"];
  }
}
