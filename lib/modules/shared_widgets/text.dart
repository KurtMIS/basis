import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

RichText richText2(String first, String second, {GestureTapCallback? onTap}) {
  return RichText(
      text: TextSpan(
          text: '$first ',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [
        TextSpan(
            text: second,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap();
              },
            style: const TextStyle(color: Colors.black))
      ]));
}
