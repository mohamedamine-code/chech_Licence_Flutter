import 'package:check_license/models/DataBaseDevice.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/pages/DashBored.dart';
import 'package:check_license/pages/SelectLicense.dart';
import 'package:check_license/pages/AddLicense.dart';
import 'package:check_license/pages/ViewArchiv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseDevices()),
        ChangeNotifierProvider(create: (_) => Databsaelicense()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Dashboard(),
        '/SelectDevice': (context) => SelectLicense(),
        '/addlicense': (context) => Addlicense(),
        '/ViewArchiv':(context)=>ViewArchiv(),

      },
    );
  }
}
