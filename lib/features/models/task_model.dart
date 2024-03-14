class TaskModel {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;
  String userId;
  TaskModel(
      {this.id = '',
      required this.title,
      required this.date,
      required this.description,
      this.isDone = false,
      required this.userId});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            date: DateTime.fromMillisecondsSinceEpoch(json['date']),
            description: json['description'],
            id: json['id'],
            isDone: json['isDone'],
            userId: json['userId']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'id': id,
      'isDone': isDone,
      'userId': userId
    };
  }
}
