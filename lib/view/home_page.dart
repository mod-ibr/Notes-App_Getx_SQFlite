import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app_getx_sqflite/controller/note_controller.dart';
import 'package:notes_app_getx_sqflite/widgets/alarm_dialog.dart';
import 'package:notes_app_getx_sqflite/widgets/searchbar.dart';

import 'add_new_note_page.dart';
import 'note_detail_page.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());

  HomePage({Key? key}) : super(key: key);

  Widget emptyNotes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/note.json'),
        const SizedBox(
          height: 50,
        ),
        Text(
          "No Notes Yet",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.amber[900]),
        ),
      ],
    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: StaggeredGridView.countBuilder(
          itemCount: controller.notes.length,
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 20.0,
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  NoteDetailPage(),
                  arguments: index,
                );
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      contentText:
                          "Are you sure you want to delete this note ?",
                      confirmFunction: () {
                        controller.deleteNote(controller.notes[index].id!);
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (controller.notes[index].title.isEmpty)
                          ? 'No Title'
                          : controller.notes[index].title,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      (controller.notes[index].content.isEmpty)
                          ? "No Content"
                          : controller.notes[index].content,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.notes[index].dateTimeEdited,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          "Note App",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber[900],
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          ),
          PopupMenuButton(
            color: Colors.white,
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      contentText: "Are you sure you want to delete all notes?",
                      confirmFunction: () {
                        controller.deleteAllNotes();
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Delete All Notes",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.delete,
                      size: 17,
                      color: Colors.red[900],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => controller.isEmpty() ? emptyNotes() : viewNotes(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Text('Add Note'),
            Icon(
              Icons.add,
            ),
          ],
        ),
        backgroundColor: Colors.amber[900],
        onPressed: () {
          Get.to(() => AddNewNotePage());
        },
      ),
    );
  }
}
