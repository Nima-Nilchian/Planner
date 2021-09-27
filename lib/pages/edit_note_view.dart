import 'package:daily_excersises/model/notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notes.dart';

class EditNoteView extends StatelessWidget {

  var data = Get.arguments;

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  Widget build(BuildContext context) {
    _noteController.text = data.note;
    _titleController.text = data.title.value;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration.collapsed(hintText: "Title"),
                  style: TextStyle(fontSize: 19),
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.grey,
                  cursorWidth: 2,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                ),
                Divider(height: 40,thickness: 2,),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration.collapsed(hintText: "Your note"),
                  style: TextStyle(fontSize: 19),
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
            data.title.value = _titleController.text;
            data.note = _noteController.text;

            Get.back();
            Get.snackbar(
                "Edit",
                "your Note has been Edited",
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
