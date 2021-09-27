import 'package:daily_excersises/model/notes.dart';
import 'package:daily_excersises/shared_preferences/note_references.dart';
import 'package:get/get.dart';

class NoteController extends GetxController{

  var _pref = NotePreference();

  var selectedCategory = Category.defaultCat().obs;

  @override
  void onInit() async{
    super.onInit();

    await _pref.fetchCategories();
    await _pref.fetchNotes();

    if(Category.allCategories.length < 1)
      Category("Untitled");

    selectedCategory.value = Category.allCategories[0];
  }

  @override
  void onClose() {
    super.onClose();

    _pref.saveCategories();
    _pref.saveNotes();
  }
}