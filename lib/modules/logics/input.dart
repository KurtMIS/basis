import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

import '../../repositories/input_repo.dart';
import '../../services1/locator.dart';
import '../models/info/info.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Input {
  final inputRepo = locator.get<InputRepo>();
  final passportImage$ = BehaviorSubject<String>.seeded('');
  final receiptImage$ = BehaviorSubject<String>.seeded('');
  final picker = ImagePicker();
  var isAdmin = false;
  var info = Info();

  Future<void> setInfo(Info req, BuildContext context) async {
    await inputRepo.setInfo(req);
  }

  Future<String> pickImage(bool isCamera, String id, String folderName,
      BehaviorSubject subject) async {
    final pickedFile = await picker.pickImage(
        imageQuality: 50,
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    var imgPath = '';
    if (pickedFile != null) {
      subject.add('z');
      final imageSent = await uploadImage(
          folderName: folderName,
          file: await pickedFile.readAsBytes(),
          path: pickedFile.path,
          imageName: id);

      await imageSent
          .then((x) async {
            imgPath = await downloadImage(id);
          })
          .whenComplete(() => subject.add(imgPath))
          .onError((error, stackTrace) {
            subject.add(imgPath);
            return null;
          });
    }
    return imgPath;
  }

  Future<firebase_storage.UploadTask> uploadImage<T>(
      {required String folderName,
      required String imageName,
      required Uint8List file,
      required String path,
      String? url}) async {
    late firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child('/$imageName.jpg');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg', customMetadata: {'picked-file-path': path});

    try {
      if (kIsWeb) {
        uploadTask = ref.putData(await file, metadata);
      }
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
    return Future.value(uploadTask);
  }

  Future<String> downloadImage(String imagePath) async {
    final link = await firebase_storage.FirebaseStorage.instance
        .ref('passport/$imagePath.jpg')
        .getDownloadURL();
    return link;
  }

  populateInput(Info info2) {
    info = info2;
  }
}
