import 'package:daily_excersises/model/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotePreference {

  Future<void> saveCategories() async{
    var pref = await SharedPreferences.getInstance();

    var categories = Category.allCategories.map((element) => json.encode(element.toMap())).toList();
    await pref.setStringList("categories", categories);

  }

  Future<void>  fetchCategories() async{
    var pref = await SharedPreferences.getInstance();

    var categories = pref.getStringList("categories") ?? [];
    Category.allCategories.value = categories.map((e) => Category.fromMap(json.decode(e))).toList();

  }

  Future<void> saveNotes() async{
    var pref = await SharedPreferences.getInstance();
    var cat = Category.allCategories;
    
    for(int i = 0; i < cat.length; i++){
      var notes = cat[i].allNotes.value.map((element) => json.encode(element.toMap())).toList();
      await pref.setStringList("note$i", notes.cast<String>());
    }
  }

  Future<void> fetchNotes() async{
    var pref = await SharedPreferences.getInstance();
    var cat = Category.allCategories;

    for(int i = 0; i < cat.length; i++){

      var notes = pref.getStringList("note$i") ?? [] ;
      cat[i].allNotes.value = notes.map((e) => Notes.fromMap(json.decode(e))).toList();
    }
  }
}