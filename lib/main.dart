import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/locator.dart';
import 'services/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (!kIsWeb) {
  //   final dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  // }
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAnH9xK-e4iaUDN7h6c5N5hjuqBkBxAMyE",
          authDomain: "strongholdofw.firebaseapp.com",
          projectId: "strongholdofw",
          storageBucket: "strongholdofw.appspot.com",
          messagingSenderId: "569623404625",
          appId: "1:569623404625:web:de462d63650e7a89ff5870"));
  locatorSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stronghold OFW',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'input',
      routes: routes(),
    );
  }
}
