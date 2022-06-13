import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

final mqHeight = (BuildContext context) => MediaQuery.of(context).size.height;
final mqWidth = (BuildContext context) => MediaQuery.of(context).size.width;

bool isWeb(BuildContext context) {
  return kIsWeb && mqWidth(context) / mqHeight(context) > 1.4;
}
