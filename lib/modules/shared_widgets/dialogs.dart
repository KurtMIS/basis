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
