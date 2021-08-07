class Note {
  String? title;
  String? Description;
  DateTime? time;

  Note({this.title, this.Description, this.time});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        title: json['title'],
        Description: json['Description'],
        time: json['time']);
  }

  Map<String, dynamic> tojson() {
    return {
      "title": title,
      "Description": Description,
      "time": time,
    };
  }
}
