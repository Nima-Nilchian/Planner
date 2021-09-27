import 'package:get/get.dart';
class Todo{

  RxString title = "".obs;
  RxBool done = false.obs;
  static var allWorks = [].obs;

  Todo(String titel){
    this.title.value = titel;
    allWorks.add(this);
  }

  Todo.fromMap(Map items){
    this.title.value = items["title"];
    this.done.value = items["done"];
  }

  Map toMap(){

    return {
      "title": this.title.value,
      "done": this.done.value,
    };
  }

}