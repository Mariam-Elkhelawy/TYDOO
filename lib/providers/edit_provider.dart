import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier {
  DateTime chosenDate = DateTime.now();

  selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        initialDate: chosenDate);
    if (selectedDate != null) {
      chosenDate = selectedDate;
      notifyListeners();
    }
  }
}
