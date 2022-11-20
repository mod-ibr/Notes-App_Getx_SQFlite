import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app_getx_sqflite/controller/note_controller.dart';

class AddNewNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  AddNewNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.titleController.clear();
    controller.contentController.clear();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "New Note",
          style: TextStyle(
            color: Colors.amber[900],
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.amber[900],
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
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[900]!.withOpacity(0.5),
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
                decoration: InputDecoration(
                  hintText: "Add Content",
                  hintStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.amber[900]!.withOpacity(0.5),
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
          controller.addNoteToDatabase();
        },
      ),
    );
  }
}
