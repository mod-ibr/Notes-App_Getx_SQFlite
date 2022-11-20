import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes_app_getx_sqflite/controller/note_controller.dart';
import 'package:notes_app_getx_sqflite/widgets/alarm_dialog.dart';

import 'edit_note_page.dart';
import 'home_page.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteController controller = Get.find();

  NoteDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.notes[i].title.isEmpty
              ? 'No Title'
              : controller.notes[i].title,
          style: TextStyle(
            color: Colors.amber[900],
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.amber[900],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {
              Get.to(
                EditNotePage(),
                arguments: i,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Get.bottomSheet(
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialogWidget(
                                contentText:
                                    "Are you sure you want to delete the note?",
                                confirmFunction: () {
                                  controller
                                      .deleteNote(controller.notes[i].id!);
                                  Get.offAll(HomePage());
                                },
                                declineFunction: () {
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.red[900],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: TextButton(
                        onPressed: () {
                          controller.shareNote(
                            controller.notes[i].title,
                            controller.notes[i].content,
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.amber[900],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.amber[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.black26),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Created :  ${controller.notes[i].dateTimeCreated}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[900]!.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Last Edited : ${controller.notes[i].dateTimeEdited}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[900]!.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
              );
            },
          ),
        ],
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => Scrollbar(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Title',
                    style: TextStyle(
                      color: Colors.amber[900],
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    (controller.notes[i].title.isEmpty)
                        ? "No Title"
                        : controller.notes[i].title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(color: Colors.black26),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Content',
                    style: TextStyle(
                      color: Colors.amber[900],
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    (controller.notes[i].content.isEmpty)
                        ? 'No Content'
                        : controller.notes[i].content,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
