import 'package:daily_excersises/controller/note_controller.dart';
import 'package:daily_excersises/pages/add_note_view.dart';
import 'package:daily_excersises/pages/edit_note_view.dart';
import 'package:daily_excersises/pages/home.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daily_excersises/model/notes.dart';

class NotesView extends StatelessWidget {

  final controller = Get.put(NoteController());

  final txt = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Notes"),
        ),
      ),

      /// Categories
      drawer: Drawer(
        child: Obx(() => ListView(
                children: Category.allCategories
                    .map<Widget>(
              (element) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  key: Key(element.category.value),
                  background: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  confirmDismiss: (_) async {
                    if (Category.allCategories.length <= 1) {
                      Get.snackbar(
                          "Error", "There should be at least one category",
                          snackPosition: SnackPosition.BOTTOM);
                      return false;
                    }
                    return true;
                  },
                  onDismissed: (_) {
                    if (Category.allCategories[0] == element)
                      controller.selectedCategory.value = Category.allCategories[1];

                    else if (controller.selectedCategory.value == element)
                      controller.selectedCategory.value = Category.allCategories[0];

                    Category.allCategories.remove(element);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE0A96D),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                        leading: Icon(Icons.category),
                        title: Text(
                          "${element.category.value}",
                          style: TextStyle(
                              color: element.category.value ==
                                      (controller.selectedCategory.value.category.value)
                                  ? Color(0xFF000000)
                                  : Color(0xFFDFDFDF)),
                        ),
                        onTap: () {
                          controller.selectedCategory.value = element;
                          Navigator.pop(context);
                        },
                        onLongPress: () => editCategory(element)),
                  ),
                ),
              ),
            ).followedBy([
              Padding(
                padding: EdgeInsets.all(8),
                child: DottedBorder(
                  strokeWidth: 2,
                  radius: Radius.circular(15),
                  borderType: BorderType.RRect,
                  dashPattern: [4, 4],
                  child: Container(
                    // margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    width: double.infinity,
                    child: TextButton(
                      child: Text("Add category"),
                      onPressed: addCategory,
                    ),
                  ),
                ),
              ),
            ]).toList())),
      ),

      /// Notes
      body: Obx(() => ListView.builder(
            itemCount: controller.selectedCategory.value.allNotes.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() => Padding(
                padding: const EdgeInsets.all(10),
                child: Dismissible(
                      key: Key(controller.selectedCategory.value.allNotes[index].id.value),
                      background: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onDismissed: (_) {
                        controller.selectedCategory.value.allNotes.removeAt(index);

                        Get.snackbar("Done", "Note deleted",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 1));
                      },
                      child: Container(
                        // margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF53E4F),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.note),
                          title: Text(
                            controller.selectedCategory.value.allNotes[index].title.value,
                            style: TextStyle(
                                color: Color(0xFFF2F2F2),
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Get.to(() => EditNoteView(),
                                arguments: controller.selectedCategory.value.allNotes[index]);
                          },
                        ),
                      ),
                    ),
              ));
            })),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.off(() => HomePage());
            },
            child: Icon(Icons.arrow_back),
            heroTag: null,
          ),
          FloatingActionButton(
            backgroundColor: Color(0xFF195190),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              Get.to(() => AddNote(),
                  arguments: controller.selectedCategory.value.category.value);
            },
            child: Icon(Icons.add),
            heroTag: null,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  void addCategory() {
    Get.dialog(AlertDialog(
      title: Text("Add category"),
      actions: [
        ElevatedButton(
            child: Text("Save"),
            onPressed: () {
              Category(txt.text);
              Get.back();
              txt.clear();
            })
      ],
      content: TextField(
        controller: txt,
        decoration: InputDecoration(
          hintText: "category name",
        ),
      ),
    ));
  }

  void editCategory(Category category) {
    txt.text = category.category.value;
    Get.dialog(AlertDialog(
      title: Text("Edit category"),
      actions: [
        ElevatedButton(
            child: Text("Save"),
            onPressed: () {
              category.category.value = txt.text;
              Get.back();
              txt.clear();
            })
      ],
      content: TextField(
        controller: txt,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: "new category name",
        ),
      ),
    ));
  }
}
