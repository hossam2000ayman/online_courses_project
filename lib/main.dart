import 'package:flutter/material.dart';
import 'package:online_courses_project/screens/root_app.dart';
import 'package:online_courses_project/themes/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: appBgColor,
        primaryColor: primary,
        
        primarySwatch: Colors.blue,
      ),
      home: RootApp(),
    );
  }
}
