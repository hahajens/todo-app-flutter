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

// TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

// String todoModelToJson(TodoModel data) => json.encode(data.toJson());

// class TodoModel {
//     TodoModel({
//         this.id,
//         this.title,
//         this.done,
//     });

//     String id;
//     String title;
//     bool done;

//     factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
//         id: json["id"],
//         title: json["title"],
//         done: json["done"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "done": done,
//     };
// }

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

  void setCheckbox(index, newValue) async {
    // Varför hittar den inte todos id här när den gör det på removefromlist?
    print(index.id);
    _todoList[index].isDone = newValue;
    notifyListeners();
    await ApiService.updateTodo(index.id);
    await getTodoList();
  }
}
