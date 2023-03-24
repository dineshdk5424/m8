import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:m8/AppWidget/DashboardWidget/View/DashboardPage.dart';

void main() {
 final LocalStorage storage = new LocalStorage('local_store');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppWrapper(),
    );
  }
}

class AppWrapper extends StatefulWidget {
  AppWrapper({Key? key}) : super(key: key);

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    return DashboardScreen();
  }
}
