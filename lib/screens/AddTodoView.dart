import 'package:flutter/material.dart';

import '../model.dart';

class AddTodoView extends StatelessWidget {
  final TextEditingController descriptionController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lägg till Todo",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      //TextField som lagrar input i TextEditingController descriptionController
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextField(
                style: TextStyle(fontSize: 18),
                controller: descriptionController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Lägg till uppgift...',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 50,
              width: 110,
              child: RaisedButton(
                elevation: 10,
                color: Colors.blueGrey,
                child: Text('ADD',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
                onPressed: () {
                  // descriptionController skickas med som argument när TodoKonstruktorn anropas.
                  if (descriptionController.text == null ||
                      descriptionController.text == '') {
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(
                      context,
                      TodoObject(
                          description: descriptionController.text,
                          isDone: false),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
