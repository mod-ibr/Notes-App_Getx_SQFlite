import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes_app_getx_sqflite/controller/note_controller.dart';

class EditNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context)?.settings.arguments as int;

    if (controller.notes[i].title == 'No Title') {
      controller.titleController.clear();
    } else {
      controller.titleController.text = controller.notes[i].title;
    }
    if (controller.notes[i].content == 'No Content') {
      controller.contentController.clear();
    } else {
      controller.contentController.text = controller.notes[i].content;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.amber[900],
        ),
        title: Text(
          "Edit Note",
          style: TextStyle(
            color: Colors.amber[900],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Add Title",
                  hintStyle: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                  border: InputBorder.none,
                ),
              ),
              const Divider(color: Colors.black26),
              TextField(
                style: const TextStyle(
                  fontSize: 22,
                ),
                controller: controller.contentController,
                decoration: const InputDecoration(
                  hintText: "Add Content",
                  hintStyle: TextStyle(
                    fontSize: 17,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber[900],
        label: Row(
          children: const [
            Text('Save'),
            Icon(
              Icons.check,
            ),
          ],
        ),
        onPressed: () {
          controller.updateNote(
              controller.notes[i].id!, controller.notes[i].dateTimeCreated);
        },
      ),
    );
  }
}
