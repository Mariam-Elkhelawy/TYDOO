import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime date;
  Color taskColor;
  bool isDone;
  bool isImportant;
  String userId;
  String? startTime;
  String? endTime ;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    this.isDone = false,
    this.isImportant = false,
    this.taskColor = Colors.transparent,
    required this.userId,
    this.startTime,
    this.endTime,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
      isImportant: json['isImportant'],
      taskColor: hexToColor(json['taskColor']),
      userId: json['userId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'id': id,
      'isDone': isDone,
      'isImportant': isImportant,
      'taskColor': taskColor.value.toRadixString(16),
      'userId': userId,
      'startTime': startTime,
      'endTime': endTime
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
