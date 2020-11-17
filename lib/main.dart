import 'package:app_todo/screens/main_view.dart';
import 'package:flutter/material.dart';
import 'package:app_todo/screens/second_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}
