import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../contants/measure.dart';

class TextFieldShared extends StatefulWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? ctrler;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final bool? isFloatingLabel = true;
  final BoxConstraints? constraints;
  final bool? isObscureText = false;
  final bool? hasBottompadding = true;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? hintText;

  const TextFieldShared({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.ctrler,
    this.onTap,
    this.constraints,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.readOnly,
    this.keyboardType,
    this.hintText,
  }) : super(key: key);

  @override
  State<TextFieldShared> createState() => _TextFieldSharedState();
}

class _TextFieldSharedState extends State<TextFieldShared> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType ?? TextInputType.name,
      validator: widget.validator,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      readOnly: widget.readOnly ?? false,
      obscureText: widget.isObscureText == true,
      controller: widget.ctrler,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      decoration: InputDecoration(
          hintText: widget.hintText ?? '',
          constraints: widget.constraints,
          isDense: true,
          isCollapsed: true,
          contentPadding: EdgeInsets.fromLTRB(
              10,
              kIsWeb
                  ? isWeb(context)
                      ? 20
                      : 20
                  : 10,
              0,
              isWeb(context) ? 0 : 10),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          floatingLabelBehavior: widget.isFloatingLabel == true
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.never,
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
          ),
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(0.0),
            child: widget.suffixIcon,
          ),
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
          ))),
    );
  }
}

// Widget textFieldShared2(BuildContext context,
//     {String? labelText,
//     Widget? prefixIcon,
//     Widget? suffixIcon,
//     TextEditingController? ctrler,
//     bool? readOnly = false,
//     GestureTapCallback? onTap,
//     bool? isFloatingLabel = true,
//     BoxConstraints? constraints,
//     bool? isObscureText = false,
//     bool? hasBottompadding = true,
//     Function(String)? onChanged}) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: hasBottompadding == true ? 10.0 : 0.0),
//     child: TextField(
//       onChanged: onChanged,
//       textAlignVertical: TextAlignVertical.center,
//       readOnly: readOnly == true,
//       obscureText: isObscureText == true,
//       controller: ctrler,
//       cursorColor: color1,
//       onTap: () {
//         if (onTap != null) {
//           onTap();
//         }
//       },
//       decoration: InputDecoration(
//           constraints: constraints,
//           isDense: true,
//           isCollapsed: true,
//           contentPadding: EdgeInsets.fromLTRB(
//               10,
//               kIsWeb
//                   ? isWeb(context)
//                       ? 10
//                       : 20
//                   : 10,
//               0,
//               isWeb(context) ? 0 : 10),
//           enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey)),
//           floatingLabelBehavior: isFloatingLabel == true
//               ? FloatingLabelBehavior.always
//               : FloatingLabelBehavior.never,
//           floatingLabelStyle: const TextStyle(
//             color: Colors.black,
//           ),
//           labelText: labelText,
//           prefixIcon: prefixIcon,
//           suffixIcon: Padding(
//             padding: const EdgeInsets.all(0.0),
//             child: suffixIcon,
//           ),
//           labelStyle: const TextStyle(color: Colors.grey),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: color1,
//           ))),
//     ),
//   );
// }
