import 'package:check_license/models/DataBase.dart';
import 'package:check_license/pages/DashBored.dart';
import 'package:check_license/pages/SelectDevices.dart';
import 'package:check_license/pages/UpcommingExpiries.dart';
import 'package:check_license/pages/ViewLicense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>DatabaseDevices())
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
        '/SelectDevice':(context)=>Selectdevices(),
        '/UpCommingExpiries':(context)=> Upcommingexpiries(),
        '/ViewLicense':(context)=> Viewlicense(),
      },
    );
  }
}