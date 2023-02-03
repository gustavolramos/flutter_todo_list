class ToDoContent {
  ToDoContent({required this.title, required this.dateTime});
  ToDoContent.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        dateTime = DateTime.parse(json['dateTime']);

  String title;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': dateTime.toIso8601String(),
    };
  }
}
