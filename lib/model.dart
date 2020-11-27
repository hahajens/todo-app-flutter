import 'package:app_todo/Api/ApiService.dart';
import 'package:flutter/material.dart';

class TodoObject {
  String description;
  bool isDone;
  String id;

  TodoObject({@required this.description, this.isDone, this.id});

  static Map<String, dynamic> fromTodoToJson(TodoObject todo) {
    return {
      'title': todo.description,
      'isDone': todo.isDone,
    };
  }

  static TodoObject fromJsonToTodo(Map<String, dynamic> json) {
    return TodoObject(
        id: json['id'], description: json['title'], isDone: json['done']);
  }
}

class MyState extends ChangeNotifier {
  List<TodoObject> _todoList = [];
  String _filterBy = 'All';

  List<TodoObject> get list => _todoList;

  Future getTodoList() async {
    List<TodoObject> list = await ApiService.getTodoData();
    _todoList = list;
    notifyListeners();
  }

  String get filterBy => _filterBy;

  void addToList(TodoObject todo) async {
    await ApiService.addTodoData(todo);
    await getTodoList();
  }

  void removeFromList(index) async {
    print(index.id);
    await ApiService.deleteTodo(index.id);
    await getTodoList();
  }

  void setFilterBy(filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }

  bool getCheckbox(index) {
    return _todoList[index].isDone;
  }

  void setCheckbox(TodoObject todo, newValue) async {
    // Varför hittar den inte todos id här när den gör det på removefromlist?
    //print(index.id);
    todo.isDone = newValue;
    notifyListeners();
    // await ApiService.updateTodo(index.id);
    // await getTodoList();
  }
}
