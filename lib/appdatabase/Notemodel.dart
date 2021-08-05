class Note {
  String? title;
  String? Description;

  Note({this.title, this.Description});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(title: json['title'], Description: json['Description']);
  }

  Map<String, dynamic> tojson() {
    return {
      "title": title,
      "Description": Description,
    };
  }
}
