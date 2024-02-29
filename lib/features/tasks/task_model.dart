class TaskModel {
  String? id;
  String? title;
  String? description;
  int? date;
  bool? isDone;
  TaskModel(
      {this.id = '',
      required this.title,
      required this.date,
      required this.description,
      this.isDone = false});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            date: json['date'],
            description: json['description'],
            id: json['id'],
            isDone: json['isDone']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'description': description,
      'id': id,
      'isDone': isDone,
    };
  }
}
