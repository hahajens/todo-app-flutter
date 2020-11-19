import 'package:flutter/material.dart';

class ToDoObject {
  String toDo;
  bool isCheckbox;

  ToDoObject({this.toDo, this.isCheckbox});
}

class Model extends ChangeNotifier {
  List<ToDoObject> _list = [];

  List<ToDoObject> get list => _list;

  bool getCheckbox(index) {
    return _list[index].isCheckbox;
  }

  void addToList(ToDoObject object) {
    _list.add(object);
    notifyListeners();
  }

  void removeFromList(ToDoObject object) {
    _list.remove(object);
    notifyListeners();
  }

  void setCheckbox(index, input) {
    _list[index].isCheckbox = input;
    notifyListeners();
  }

  List<ToDoObject> filteredList(String filter) {
    if (filter == "Done") {
      notifyListeners();
      print(_list.where((object) => object.isCheckbox == true).toList());
      return _list.where((object) => object.isCheckbox == true).toList();
    } else if (filter == "Undone") {
      notifyListeners();
      return _list.where((object) => object.isCheckbox == false).toList();
    }

    return _list;
  }
}
