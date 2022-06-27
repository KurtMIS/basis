import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

import '../../repositories/input_repo.dart';
import '../../services/locator.dart';
import '../models/info/info.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Input {
  final inputRepo = locator.get<InputRepo>();
  final file$ = BehaviorSubject<File>();
  final bankFile$ = BehaviorSubject<File>();
  final picker = ImagePicker();

  Future<void> setInfo(Info req) async => await inputRepo.setInfo(req);
  Future<void> updateInfo(Info req, Map<String, dynamic> map) async =>
      await inputRepo.updateInfo(req, map);

  Future<firebase_storage.UploadTask> uploadImage<T>(
      {required String folderName,
      required String imageName,
      required File file,
      String? url}) async {
    // if (file == null) {
    // await Fluttertoast.showToast(
    //     msg: "File not found",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    // return ;
    // }

    late firebase_storage.UploadTask uploadTask;
    //     firebase_storage.UploadTask.fromPath(
    //   file.path,
    // );

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child('/$imageName.jpg');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    try {
      if (kIsWeb) {
        uploadTask = ref.putData(await file.readAsBytes(), metadata);
      } else {
        if (url == null) {
          uploadTask = ref.putFile(file, metadata);
        } else {
          // uploadTask = ref.putString(url, metadata);
        }
      }
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      // return null;
    }

    // await firestoreUber.setLocation(loc);
    // Fluttertoast.showToast(
    //     msg: "Sending Successful",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    return Future.value(uploadTask);
  }

  pickImage(bool isCamera, String id, String folderName) async {
    final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      final File file2 = File(pickedFile.path);
      print('first');
      print('' + file2.path);
      print('second');
      // if(kIsWeb) {
      // final res = await sendImage(id, file2, folderName);
      // }
      final res = await sendImage(id, file2, folderName);
      print('third');
      // if (res != '') {
      file$.add(file2);
      // }
    }
  }

  Future<String> downloadImage(String imagePath) async {
    final link = await firebase_storage.FirebaseStorage.instance
        .ref('passport/$imagePath.jpg')
        .getDownloadURL();
    return link;
  }

  Future<String> sendImage(String id, File file, String folderName) async {
    // final result = await picker.pickImage(
    //   source: ImageSource.gallery,
    //   imageQuality: 80,
    //   // maxHeight: 400,
    //   // maxWidth: 400,
    // );
    // if (result != null) {
    //   final File file = File(
    //     result.path,
    //   );
    // ChatMessage message;
    // String id = appId;

    final imageSent =
        await uploadImage(folderName: folderName, file: file, imageName: id);
    print('1');
    var imagePath = '';
    await imageSent.then((x) async {
      imagePath = await downloadImage(id);
      print('2');
      // message = ChatMessage(
      //     id: Uuid().v4(),
      //     text: "",
      //     user: myInfo,
      //     image: imagePath,
      //     createdAt: await mainBloc.getDateNowNTP());
      // addMessage(message);
      // });
    }).whenComplete(() => imagePath);
    print('3');
    return imagePath;
  }
}
