import 'package:app_todo/model.dart';
import 'package:app_todo/screens/main_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  var state = Model();
  runApp(ChangeNotifierProvider(create: (context) => state, child: MyApp()));
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
