import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class TodoList extends StatelessWidget {
  final List<TodoObject> todoList;
  TodoList(this.todoList);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) =>
          _todoArticle(todoList[index], context, index),
    );
  }
}

Widget _todoArticle(TodoObject todo, context, index) {
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
        state.setCheckbox(state.list[index], newValue);
      },
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Text(
          todo.description,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      secondary: IconButton(
        icon: Icon(
          Icons.highlight_remove_outlined,
          size: 28,
        ),
        onPressed: () {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeFromList(state.list[index]);
        },
      ),
    ),
  );
}
