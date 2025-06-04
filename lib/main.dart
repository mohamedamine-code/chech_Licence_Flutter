import 'package:check_license/models/DataBaseDevice.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/pages/DashBored.dart';
import 'package:check_license/pages/SelectLicense.dart';
import 'package:check_license/pages/UpcommingExpiries.dart';
import 'package:check_license/pages/ViewLicense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>DatabaseDevices()),
      ChangeNotifierProvider(create: (_)=>Databsaelicense()),
    ],
    child:const MyApp(),
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
        '/':(context)=> Dashboard(),
        '/SelectDevice':(context)=>SelectLicense(),
        '/UpCommingExpiries':(context)=> Upcommingexpiries(),
        '/ViewLicense':(context)=> Viewlicense(),
      },
    );
  }
}