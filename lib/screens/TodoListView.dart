import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../TodoList.dart';
import '../model.dart';
import 'AddTodoView.dart';

class TodoListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Att göra",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              icon: Icon(
                Icons.tune,
                size: 30,
              ),
              onSelected: (value) {
                Provider.of<MyState>(context, listen: false).setFilterBy(value);
              },
              itemBuilder: (context) => [
                PopupMenuItem(child: Text('All'), value: 'All'),
                PopupMenuItem(child: Text('Done'), value: 'Done'),
                PopupMenuItem(child: Text('Not done'), value: 'Not done'),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Consumer<MyState>(builder: (context, state, child) {
          if (state.isLoading) {
            return _loadingWidget();
          } else {
            return TodoList(_filterList(state.list, state.filterBy));
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          onPressed: () async {
            var newObject = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTodoView()));

            if (newObject != null) {
              Provider.of<MyState>(context, listen: false).addToList(newObject);
            }
          }),
    );
  }
}

List<TodoObject> _filterList(list, filterBy) {
  if (filterBy == 'All') {
    return list;
  }
  if (filterBy == 'Done') {
    return list.where((item) => item.isDone == true).toList();
  }
  if (filterBy == 'Not done')
    return list.where((item) => item.isDone == false).toList();
}

Widget _loadingWidget() {
  return Scaffold(
      body: Center(
          child: SpinKitFadingCircle(
    color: Colors.white,
    size: 70.0,
  )));
}
