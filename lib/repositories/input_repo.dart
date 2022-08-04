import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stronghold_ofw/services1/api.dart';

import '../services1/firestore.dart';
import '../modules/models/info/info.dart';

class InputRepo {
  final _service = FirestoreService.instance;
  CollectionReference info = FirebaseFirestore.instance.collection('info');
  DocumentReference documentReference(String col, String doc) =>
      FirebaseFirestore.instance.collection(col).doc(doc);

  Future<void> setInfo(Info req) async => await _service.setData(
        path: InfoApi.info(req.id),
        data: req.toJson(),
      );

  Future<bool> updateInfo(Info req, Map<String, dynamic> map) async {
    var bool = false;

    await documentReference('info', req.id)
        .update(map)
        .then((value) => bool = true)
        .onError((error, stackTrace) => bool = false);
    return bool;
  }

  // Stream<List<Info>> getInfos$() => _service.collectionStream(
  //       path: InfoApi.infos,
  //       builder: (data, documentId) {
  //         Info infos = Info.fromJson(data);
  //         return infos;
  //       },
  //       queryBuilder: (Query<Object?> query) {
  //         return query.orderBy('id', descending: true);
  //       },
  //       sort: (Info first, Info second) {
  //         return first.id.compareTo(second.id);
  //       },
  //     );

  Stream<List<Info>> searchInfo$(Info info) => _service.collectionStream(
        path: InfoApi.infos,
        builder: (data, documentId) {
          Info infos = Info.fromJson(data);
          return infos;
        },
        queryBuilder: (Query<Object?> query) {
          if (info.email.isNotEmpty) {
            query = query.where(
              'email',
              isEqualTo: info.email,
            );
          }
          if (info.submissionDate.isNotEmpty) {
            query =
                query.where('submissionDate', isEqualTo: info.submissionDate);
          }
          if (info.firstName != '0') {
            query = query.where('isPaid', isEqualTo: info.firstName == '1');
          }
          if (info.lastName != '0') {
            query = query.where('isDone', isEqualTo: info.lastName == '1');
          }

          if (info.position.isNotEmpty) {
            // query = query.limit(5);
          }
          return query;
        },
        sort: (Info first, Info second) {
          return first.id.compareTo(second.id);
        },
      );
}
