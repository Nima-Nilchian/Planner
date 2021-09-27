import 'package:daily_excersises/controller/todo_controller.dart';
import 'package:daily_excersises/model/Todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TodoView extends StatelessWidget {
  final todoCont = Get.put(TodoController());

  final txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Todo's"),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: Todo.allWorks.length,
          itemBuilder: (context, index) {
            return Obx( () {
              var obj = Todo.allWorks[index];
              return Padding(
                padding: EdgeInsets.all(7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Slidable(
                      actionPane: SlidableScrollActionPane(),
                      actions: [
                        IconSlideAction(
                            icon: Icons.edit,
                            color: Colors.green,
                            onTap: () => Get.dialog(AlertDialogWidget(
                                  txt,
                                  obj.title.value,
                                  edditing: true,
                                ))),
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          icon: Icons.delete,
                          color: Colors.black,
                          onTap: () => Todo.allWorks.remove(obj),
                        ),
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF53E4F),
                        ),
                        child: ListTile(
                          title: obj.done.value
                              ? Text(
                                  obj.title.value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.lineThrough),
                                )
                              : Text(
                                  obj.title.value,
                            style: TextStyle(color: Color(0xFFF2F2F2)),
                                ),
                          trailing: Checkbox(
                            checkColor: Colors.orange,
                            value: obj.done.value,
                            onChanged: (bool? val) {
                              obj.done.value = val;
                            },
                          ),
                        ),
                      )),
                ),
              );
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          Get.dialog(AlertDialogWidget(
            txt,
            "",
            edditing: false,
          ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      ),
    );
  }
}

class AlertDialogWidget extends StatelessWidget {

  AlertDialogWidget(this.txt, this.title, {required this.edditing}) {
    txt.text = title;
    if(edditing){
      obj = Todo.allWorks.firstWhere((element) => element.title.value.contains(title));
    }
  }

  final TextEditingController txt;
  String title;
  bool edditing;
  late var obj;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Todo")),
      content: TextField(
        controller: txt,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Title..",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text("Save"),
            onPressed: () {
              if (!edditing) Todo(txt.text);
              else {
                obj.title.value = txt.text;
              }
              Get.back();
              txt.clear();
            },
          ),
        )
      ],
    );
  }
}
