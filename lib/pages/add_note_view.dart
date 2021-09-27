import 'package:daily_excersises/controller/note_controller.dart';
import 'package:daily_excersises/model/notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddNote extends StatelessWidget {

  var data = Get.arguments;

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();



  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: "Title"),
                  style: TextStyle(fontSize: 19),
                  // keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.newline,
                  cursorColor: Colors.grey,
                  cursorWidth: 2,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                ),
                // Divider(height: 40,thickness: 2,),
                SizedBox(height: 30,),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration.collapsed(hintText: "Your note"),
                  style: TextStyle(fontSize: 19),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.none,
                  cursorColor: Colors.grey,
                  cursorWidth: 2,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            if(_titleController.text.isEmpty){
              Get.snackbar("Alert", "Title can't be empty",snackPosition: SnackPosition.BOTTOM);
              return;
            }

            Notes(data, _noteController.text,_titleController.text);
            Get.back();

            Get.snackbar(
              "Saved",
              "your Note has been saved",
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 1)
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
