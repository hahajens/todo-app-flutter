import 'package:app_todo/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const API_URL = "https://todoapp-api-vldfm.ondigitalocean.app";
const API_KEY = "2c1bd490-6daf-4975-a5dd-dd6fd5487806";

class ApiService {
  // Skicka upp data till API.
  static Future addTodoData(TodoObject todo) async {
    var json = jsonEncode(TodoObject.fromTodoToJson(todo));

    await http.post(
      '$API_URL/todos?key=$API_KEY',
      body: json,
      headers: {'Content-Type': 'application/json'},
    );
  }

//Hämta data från API
  static Future<List<TodoObject>> getTodoData() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    var json = jsonDecode(response.body);
    return json.map<TodoObject>((jsonObject) {
      return TodoObject.fromJsonToTodo(jsonObject);
    }).toList();
  }

//Ta bort data från APiI
  static Future deleteTodo(String todoId) async {
    await http.delete('$API_URL/todos/$todoId?key=$API_KEY');
  }

//Uppdatera data i API
  static Future updateTodo(TodoObject todo) async {
    String todoId = todo.id;
    var json = jsonEncode(TodoObject.fromTodoToJson(todo));
    await http.put(
      '$API_URL/todos/$todoId?key=$API_KEY',
      body: json,
      headers: {'Content-Type': 'application/json'},
    );
  }
}
