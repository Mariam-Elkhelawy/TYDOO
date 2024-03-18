import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/my_provider.dart';

class EditProvider extends ChangeNotifier {
  DateTime chosenDate = DateTime.now();

  selectDate(BuildContext context) async {
    var provider = Provider.of<MyProvider>(context, listen: false);

    DateTime? selectedDate = await showDatePicker(
        textDirection: provider.languageCode == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        locale: Locale(provider.languageCode == 'en' ? 'en' : 'ar'),
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
