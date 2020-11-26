import 'package:flutter/material.dart';

import '../model.dart';

class AddTodoView extends StatelessWidget {
  final TextEditingController descriptionController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextField(controller: descriptionController),
          ),
          Container(
            height: 50,
            width: 110,
            child: RaisedButton(
              elevation: 10,
              color: Colors.blueGrey,
              child: Text('ADD',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  TodoObject(
                      description: descriptionController.text, isDone: false),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
