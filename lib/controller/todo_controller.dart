import 'package:daily_excersises/shared_preferences/todo_preferences.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{

  var todoPref = TodoPreferences();
  @override
  void onInit() {
    
    todoPref.fetchActivities();
    super.onInit();
  }

  @override
  void onClose() {
    todoPref.saveActivities();
    super.onClose();
  }


}