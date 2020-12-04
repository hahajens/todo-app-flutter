import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class TodoList extends StatelessWidget {
  final List<TodoObject> todoList;
  TodoList(this.todoList);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) => _todoArticle(todoList[index], context),
    );
  }
}

//För varje item i listan skapas ett Card med värde från todoobjektet, alla metoder som kan utföras på dessa ligger i model.dart
Widget _todoArticle(TodoObject todo, context) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.blueGrey,
      value: todo.isDone,
      onChanged: (bool newValue) {
        var state = Provider.of<MyState>(context, listen: false);
        state.setCheckbox(todo, newValue);
      },
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Text(
          todo.description,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: todo.isDone == true ? Colors.white24 : Colors.white,
          ),
        ),
      ),
      secondary: IconButton(
        icon: Icon(
          CupertinoIcons.delete,
          size: 25,
        ),
        onPressed: () {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeFromList(todo);
        },
      ),
    ),
  );
}
