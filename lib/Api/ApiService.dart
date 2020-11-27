import 'package:app_todo/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const API_URL = "https://todoapp-api-vldfm.ondigitalocean.app";
const API_KEY = "d7d7cd08-6c7d-468f-832e-810085635d2f";

class ApiService {
  static Future addTodoData(TodoObject todo) async {
    var json = jsonEncode(TodoObject.fromTodoToJson(todo));

    await http.post(
      '$API_URL/todos?key=$API_KEY',
      body: json,
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<List<TodoObject>> getTodoData() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    var json = jsonDecode(response.body);
    return json.map<TodoObject>((jsonObject) {
      return TodoObject.fromJsonToTodo(jsonObject);
    }).toList();
  }

  static Future deleteTodo(String todoId) async {
    await http.delete('$API_URL/todos/$todoId?key=$API_KEY');
  }

  static Future updateTodo(String todoId) async {
    await http.put('$API_URL/todos/$todoId?key=$API_KEY');
  }
}
