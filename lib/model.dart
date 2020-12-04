import 'package:app_todo/services/ApiService.dart';
import 'package:flutter/material.dart';

class TodoObject {
  String description;
  bool isDone;
  String id;
//Konstruktor, skapar varje Todo-Objekt
  TodoObject({this.description, this.isDone, this.id});

//Metod som skriver om ett dart-objekt till ett JSON-objekt när vi ska skicka data till API
  static Map<String, dynamic> fromTodoToJson(TodoObject todo) {
    return {
      'title': todo.description,
      'done': todo.isDone,
    };
  }

//Metod som skriver om JSON-objekt till dart-objekt vi kan använda i appen, när vi hämtar data från API.
  static TodoObject fromJsonToTodo(Map<String, dynamic> json) {
    return TodoObject(
        id: json['id'], description: json['title'], isDone: json['done']);
  }
}

class MyState extends ChangeNotifier {
  List<TodoObject> _todoList = [];
  String _filterBy = 'All';
  bool _isLoading = false;

//getters
  bool get isLoading => _isLoading;
  List<TodoObject> get list => _todoList;
  String get filterBy => _filterBy;

//Hämtar data från api, anropas alltid när förändringar görs, då ny data finns att hämta.
//Här sätts en bool isLoading till sann för att kunna visa en spinner under tiden den hämtar data, och sedan falsk när den är klar.
  Future getTodoList() async {
    _isLoading = true;
    notifyListeners();
    List<TodoObject> list = await ApiService.getTodoData();
    _todoList = list;
    _isLoading = false;
    notifyListeners();
  }

//Metod som anropas när nytt objekt ska läggas till.
  void addToList(TodoObject todo) async {
    await ApiService.addTodoData(todo);
    await getTodoList();
  }

//Anropas när du klickar på tabort-knappen, uppdaterar API
  void removeFromList(TodoObject todo) async {
    await ApiService.deleteTodo(todo.id);
    await getTodoList();
  }

//anropas när du klickar i checkboxen, sätter nytt boolskt värde och uppdaterar API
  void setCheckbox(TodoObject todo, newValue) async {
    todo.isDone = newValue;
    await ApiService.updateTodo(todo);
    await getTodoList();
  }

//Sätter filtervariabeln i denna klass till det man "klickar på" i PopupButton.
  void setFilterBy(filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
