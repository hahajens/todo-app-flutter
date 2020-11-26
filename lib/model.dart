import 'package:flutter/material.dart';

class TodoObject {
  String description;
  bool isDone;

  TodoObject({@required this.description, this.isDone});
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

  String get filterBy => _filterBy;

  void addToList(TodoObject todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void removeFromList(index) {
    _todoList.remove(index);
    notifyListeners();
  }

  void setFilterBy(filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }

  bool getCheckbox(index) {
    return _todoList[index].isDone;
  }

  void setCheckbox(index, input) {
    _todoList[index].isDone = input;
    notifyListeners();
  }
}
