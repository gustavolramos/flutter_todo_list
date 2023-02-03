import 'dart:convert';
import 'package:learning_todo_lists/support_classes/todo_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoRepository {
  static const toDoListKey = 'todo_list';
  late SharedPreferences sharedPreferences;

  Future<List<ToDoContent>> getToDoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(toDoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => ToDoContent.fromJson(e)).toList();
  }

  void saveToDoList(List<ToDoContent> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString(toDoListKey, jsonString);
    print(jsonString);
  }
}
