import 'package:daily_excersises/pages/gratitude.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GratitudePreferences {

  var pref;

  Future getIns() async{
    pref = await SharedPreferences.getInstance();
  }


  void saveText(var txt,var num) async {
    await getIns();

    await pref.setString("text$num", txt);
  }


   void getText1() async{

    await getIns();
    var txt = pref.getString("text1");
    Gratitude.text1.text = txt;
  }

  void getText2() async{

    await getIns();
    var txt = pref.getString("text2");
    Gratitude.text2.text = txt;
  }

  void getText3() async{

    await getIns();
    var txt = pref.getString("text3");
    Gratitude.text3.text = txt;
  }

}