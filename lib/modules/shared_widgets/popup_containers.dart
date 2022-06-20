import 'package:flutter/material.dart';
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

dialogChoiceShared(BuildContext? ctx,
    {required String title,
    required List<String> list,
    required TextEditingController ctrler}) {
  return Dialog(
    child: Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '    $title',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(ctx!);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ))
                ],
              )),
          Container(
              padding: const EdgeInsets.only(top: 5),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length + 2,
                separatorBuilder: (context, index) =>
                    const Divider(height: 0.5),
                itemBuilder: (context, index) {
                  if (index == 0 || index == list.length + 1) {
                    return Container();
                  }
                  return scheduleList(context, list[index - 1], ctrler);
                },
              ))
        ],
      ),
    ),
  );
}

scheduleList(BuildContext context, String str, TextEditingController ctrler) {
  String selectedTile = '';
  selectedTile = ctrler.text;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        trailing: str == selectedTile
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : const Text(''),
        selected: str == selectedTile,
        selectedTileColor: Colors.blue,
        title: Text(str,
            style: TextStyle(
                color: str == selectedTile ? Colors.white : Colors.black)),
        onTap: () {
          Navigator.pop(context, str);
        },
      ),
    ],
  );
}
