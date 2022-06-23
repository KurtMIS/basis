import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stronghold_ofw/services/api.dart';

import '../services/firestore.dart';
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

  Future<void> updateInfo(Info req, Map<String, dynamic> map) async =>
      await documentReference('info', req.id).update(map);

  Stream<List<Info>> getInfos$() => _service.collectionStream(
        path: InfoApi.infos,
        builder: (data, documentId) {
          Info infos = Info.fromJson(data);
          return infos;
        },
        queryBuilder: (Query<Object?> query) {
          return query.orderBy('id', descending: true);
        },
        sort: (Info first, Info second) {
          return first.id.compareTo(second.id);
        },
      );

  Stream<List<Info>> searchInfo$(Info info) => _service.collectionStream(
        path: InfoApi.infos,
        builder: (data, documentId) {
          Info infos = Info.fromJson(data);
          return infos;
        },
        queryBuilder: (Query<Object?> query) {
          return query
              .where(
                'mobileNumber',
                isEqualTo: info.mobileNumber,
              )
              .where('isPaid', isEqualTo: info.isPaid)
              .where('isDone', isEqualTo: info.isDone)
              .where('submissionDate', isEqualTo: info.submissionDate)
              .where('processDate', isEqualTo: info.processedDate)
              .where('dateOfBirth', isEqualTo: info.dateOfBirth);
        },
        sort: (Info first, Info second) {
          return first.id.compareTo(second.id);
        },
      );
}
