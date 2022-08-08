import 'package:dreamlist/models/todo.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }
}
