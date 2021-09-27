import 'dart:async';

import 'package:daily_excersises/pages/gratitude.dart';
import 'package:daily_excersises/shared_preferences/gratitude_preferences.dart';

import 'package:get/get.dart';

class GratitudeController extends GetxController {
  var _pref = GratitudePreferences();

  @override
  void onInit() {

    removeTextAfterADay();
    _pref.getText1();
    _pref.getText2();
    _pref.getText3();

    super.onInit();
  }

  @override
  void onClose() {

    _pref.saveText(Gratitude.text1.text, 1);
    _pref.saveText(Gratitude.text2.text, 2);
    _pref.saveText(Gratitude.text3.text, 3);

    super.onClose();
  }

  late Timer _timer;
  void removeTextAfterADay(){

    _timer = Timer.periodic(Duration(days: 1), (timer) {

      for(int i = 0; i <= 3; i++)
        _pref.saveText(Gratitude.text3.text, 3);

    });
  }
}
