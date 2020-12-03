import 'package:app_todo/services/ApiService.dart';
import 'package:flutter/material.dart';

class TodoObject {
  String description;
  bool isDone;
  String id;

  TodoObject({this.description, this.isDone, this.id});

  static Map<String, dynamic> fromTodoToJson(TodoObject todo) {
    return {
      'title': todo.description,
      'done': todo.isDone,
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
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<TodoObject> get list => _todoList;
  String get filterBy => _filterBy;

  Future getTodoList() async {
    _isLoading = true;
    notifyListeners();
    List<TodoObject> list = await ApiService.getTodoData();
    _todoList = list;
    _isLoading = false;
    notifyListeners();
  }

  void addToList(TodoObject todo) async {
    await ApiService.addTodoData(todo);
    await getTodoList();
  }

  void removeFromList(TodoObject todo) async {
    await ApiService.deleteTodo(todo.id);
    await getTodoList();
  }

  void setCheckbox(TodoObject todo, newValue) async {
    todo.isDone = newValue;
    await ApiService.updateTodo(todo);
    await getTodoList();
  }

  void setFilterBy(filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
