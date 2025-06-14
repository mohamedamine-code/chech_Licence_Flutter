import 'package:check_license/api/Fire_baseApi.dart';
import 'package:check_license/api/LocalNotificationServerce.dart';
import 'package:check_license/firebase_options.dart';
import 'package:check_license/models/DataBaseDevice.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/pages/DashBored.dart';
import 'package:check_license/pages/SelectLicense.dart';
import 'package:check_license/pages/AddLicense.dart';
import 'package:check_license/pages/ViewArchiv.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📥 Background message received: ${message.notification?.title}');
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FireBaseapi().initNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationService.initialize();
  await dotenv.load(fileName: ".env");

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
