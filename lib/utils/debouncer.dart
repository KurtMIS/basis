import 'dart:async';

class Debouncer {
  Debouncer({required this.delay});
  final Duration delay;
  Timer? timer;

  run(Function() action) {
    timer?.cancel();
    timer = Timer(delay, action);
  }
}
