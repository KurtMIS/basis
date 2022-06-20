import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stronghold_ofw/services/api.dart';

import '../services/firestore.dart';
import '../modules/models/info/info.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class InputRepo {
  // FirebaseUsers._();
  // static final instance = FirebaseUsers._();
  // final uid = Modular.get<AuthService>().getCurrentUserId();
  // final uid = auth.getCurrentUserId();
  final _service = FirestoreService.instance;

  Future<void> setInfo(Info req) async => await _service.setData(
        path: InfoApi.info(req.id),
        data: req.toJson(),
      );

  Stream<List<Info>> users$() => _service.collectionStream(
        path: InfoApi.infos,
        builder: (data, documentId) {
          Info infos = Info.fromJson(data);
          return infos;
        },
        queryBuilder: (Query<Object?> query) {
          print('query builder');
          return query.orderBy('id', descending: true);
        },
        sort: (Info first, Info second) {
          print('sort?');
          return first.id.compareTo(second.id);
        },
      );
}
