import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

selectPopupDate(BuildContext? context, TextEditingController dateCtrler) async {
  final selected = await showDatePicker(
    context: context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (selected != null && selected != DateTime.now()) {
    dateCtrler.text = DateFormat('dd/MM/yyyy').format(selected);
  }
}
