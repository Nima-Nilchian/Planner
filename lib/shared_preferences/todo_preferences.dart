import 'dart:convert';
import 'package:daily_excersises/model/Todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoPreferences {

  Future saveActivities() async {
    var _pref = await SharedPreferences.getInstance();

    var allActivities =
        Todo.allWorks.map((element) => jsonEncode(element.toMap())).toList();
    _pref.setStringList("allActivities", allActivities);
  }

  Future fetchActivities() async {
    var _pref = await SharedPreferences.getInstance();

    var allActivities = _pref.getStringList("allActivities") ?? [];
    Todo.allWorks.value =
        allActivities.map((e) => Todo.fromMap(jsonDecode(e))).toList();
  }

}
