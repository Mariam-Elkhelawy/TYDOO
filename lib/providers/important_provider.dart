import 'package:flutter/material.dart';
import 'package:todo_app/features/data/models/task_model.dart';

class ImportantProvider with ChangeNotifier {
  List<TaskModel> _tasks = []; // Your list of tasks

  List<TaskModel> get tasks => _tasks;

  List<TaskModel> get importantTasks => _tasks.where((task) => task.isImportant).toList();

  void setTasks(List<TaskModel> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

// Add other methods to add, remove, update tasks, etc.
}
