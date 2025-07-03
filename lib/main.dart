import 'package:check_license/api/Fire_baseApi.dart';
import 'package:check_license/api/LocalNotificationServerce.dart';
import 'package:check_license/firebase_options.dart';
import 'package:check_license/models/DataBaseDevice.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/pages/NewAddLicense.dart';
import 'package:check_license/pages/NewArchive.dart';
import 'package:check_license/pages/NewDashBored.dart';
import 'package:check_license/pages/Newselectlicense.dart';
import 'package:check_license/pages/license_list_page.dart';
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
      initialRoute: '/NEW',
      routes: {
        '/NEW': (context) => const DashboardPage(),
        '/NewSelectDevice': (context) =>  LicenseGridPage(),
        '/Newaddlicense': (context) =>  AddLicenseScreen(),
        '/NewViewArchiv': (context) =>  ArchiveGridPage(),
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/licenseList') {
      //     final args = settings.arguments as Map<String, dynamic>?;

      //     if (args == null || !args.containsKey('title') || !args.containsKey('licenses')) {
      //       return MaterialPageRoute(
      //         builder: (_) => const Scaffold(
      //           body: Center(child: Text('Invalid arguments for license list page')),
      //         ),
      //       );
      //     }

      //     return MaterialPageRoute(
      //       builder: (_) => LicenseListPage(
      //         title: args['title'] as String,
      //         licenses: args['licenses'] as List<dynamic>,
      //       ),
      //     );
      //   }
      //   // Unknown route fallback
      //   return MaterialPageRoute(
      //     builder: (_) => const Scaffold(
      //       body: Center(child: Text('Page not found')),
      //     ),
      //   );
      // },
    
    
    
    
    
    
    );
  }
}
