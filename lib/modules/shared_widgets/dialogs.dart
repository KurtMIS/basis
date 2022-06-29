import 'package:flutter/material.dart';

showDialogShared(BuildContext context, Widget page,
    {EdgeInsets? padding}) async {
  // await delayed(100);
  return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (_) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            // insetAnimationDuration: const Duration(milliseconds: 0),
            insetPadding: padding,
            child: page,
          ));
}

Future<bool> showConfirmDialog(
  BuildContext context,
  String question,
) async {
  var res = false;
  await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(question),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              res = true;
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  return res;
}
