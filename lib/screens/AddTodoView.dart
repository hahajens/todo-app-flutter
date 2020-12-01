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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextField(
                controller: descriptionController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Lägg till uppgift...',
                  border: OutlineInputBorder(),
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
                  print(descriptionController.text);
                  if (descriptionController.text == null ||
                      descriptionController.text == '') {
                    Navigator.pop(context);
                  } else {
                    print(descriptionController.text);
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
