import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../repositories/input_repo.dart';
import '../../services/locator.dart';
import '../models/info/info.dart';

class View {
  final inputRepo = locator.get<InputRepo>();

  final infoList$ = BehaviorSubject<List<Info>>.seeded([]);
  getInfos(Info info) async {
    inputRepo.searchInfo$(info).listen((event) {
      print('listening..... ${event.length}');
      infoList$.add(event);
    });
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
