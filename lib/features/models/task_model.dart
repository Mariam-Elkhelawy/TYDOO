import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime date;
  Color taskColor;
  bool isDone;
  String userId;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    this.isDone = false,
    required this.taskColor,
    required this.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
      taskColor: hexToColor(json['taskColor']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'id': id,
      'isDone': isDone,
      'taskColor': taskColor.value.toRadixString(16), // Convert the color back to hex string
      'userId': userId,
    };
  }
}
Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'ff$hex';
  }
  return Color(int.parse(hex, radix: 16));
}
