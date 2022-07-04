import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../repositories/input_repo.dart';
import '../../services/locator.dart';
import '../models/info/info.dart';

class View {
  final inputRepo = locator.get<InputRepo>();
  late StreamSubscription _subscription;
  var summary = {};

  set subscription(StreamSubscription subscription) {
    _subscription = subscription;
  }

  final infoList$ = BehaviorSubject<List<Info>>.seeded([]);
  getInfos(Info info) async {
    subscription = inputRepo.searchInfo$(info).listen((event) {
      summary = {
        'paid': event.where((element) => element.isPaid).length,
        'done': event.where((element) => element.isDone).length,
        'total': event.length
      };
      infoList$.add(event);
    });
  }

  cancelSubscription() {
    _subscription.cancel();
  }

  Future<void> updateInfo(
      Info req, Map<String, dynamic> map, BuildContext context) async {
    final res = await inputRepo.updateInfo(req, map);
    if (res) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Updated Successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error, Try again')));
    }
  }
}
