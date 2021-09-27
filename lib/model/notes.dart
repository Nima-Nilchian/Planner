import 'package:daily_excersises/pages/notes.dart';
import 'package:get/get.dart';
import 'dart:math';

class Notes {
  late String category;
  late String note;
  var title = "".obs;
  RxString id = "".obs;
  var rand = Random();

  Notes(this.category, this.note, String title) {
    this.title.value = title;
    this.id.value = rand.nextInt(10000).toString();
    Category.allCategories
        .firstWhere((e) => e.category.value.contains(category))
        .allNotes
        .add(this);
  }

  Notes.fromMap(Map item) {
    this.title.value = item["title"];
    this.note = item["note"];
    this.category = item["category"];
    this.id.value = item["id"];
  }

  Map toMap() {
    return {
      "note": this.note,
      "title": this.title.value,
      "category": category,
      "id": this.id.value,
    };
  }
}

class Category {
  late RxString category = "".obs;
  var allNotes = [].obs;

  static var allCategories = [].obs;

  Category(cat) {
    this.category.value = cat;

    if (!exist(cat)) allCategories.add(this);

  }

  Category.defaultCat();

  exist(var cat) {
    for (int i = 0; i < allCategories.length; i++) {
      if (allCategories[i].category == cat) return true;
    }
    return false;
  }

  Map toMap() {
    var allnotes = this.allNotes.map((element) => element.toMap()).toList();
    return {
      "category": this.category.value,
      "allNotes": allnotes,
    };
  }

  Category.fromMap(Map item) {
    this.category.value = item["category"];
    this.allNotes.value = item["allNotes"];
  }
}
