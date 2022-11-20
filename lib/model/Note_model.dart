class Note {
  int? id;
  late String title;
  late String content;
  late String dateTimeEdited;
  late String dateTimeCreated;

  Note(
      {this.id,
      required this.title,
      required this.content,
      required this.dateTimeEdited,
      required this.dateTimeCreated});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "content": this.content,
      "dateTimeEdited": this.dateTimeEdited,
      "dateTimeCreated": this.dateTimeCreated,
    };
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    content = map["content"];
    dateTimeEdited = map["dateTimeEdited"];
    dateTimeCreated = map["dateTimeCreated"];
  }
}
